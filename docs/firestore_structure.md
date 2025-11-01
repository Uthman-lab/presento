# Firestore Database Structure

This document describes the optimized Firestore database structure for the Task Master Attendance System, supporting comprehensive attendance tracking with multi-institution, multi-role architecture.

## Design Principles

- **Minimal Fields**: Only essential data stored
- **Top-Level Users & Institutions**: Global users with multi-institution support
- **Composite IDs**: Deterministic document IDs for fast access
- **Subcollections**: Scalable structure for large datasets

## Database Structure

### Root Collections

```
/users/{userId}/
├── uid: string (Firebase Auth UID)
├── email: string
├── name: string
├── isSuperAdmin: boolean (optional, default: false)
│   └── If true, user has system-wide access to all institutions
├── roles: map<institutionId, InstitutionRole>
│   └── {institutionId}: {
│       role: string (institution_admin, teacher, student, class_rep, stakeholder),
│       assignedClassId: string (optional, for class_reps),
│       isActive: boolean,
│       joinedAt: timestamp
│   }
│   └── Note: Super admin may have empty roles map or legacy roles for backward compatibility
├── currentInstitutionId: string (optional)
├── createdAt: timestamp
└── updatedAt: timestamp

/institutions/{institutionId}/
├── name: string
├── createdAt: timestamp
└── updatedAt: timestamp
```

### Institution Subcollections

#### Classes

```
/institutions/{institutionId}/classes/{classId}/
├── name: string
├── description: string (optional)
├── createdAt: timestamp
└── updatedAt: timestamp
```

#### Students

```
/institutions/{institutionId}/students/{studentId}/
├── studentId: string (student ID number)
├── name: string
├── classId: string (reference to class)
├── email: string (optional)
├── phone: string (optional)
├── createdAt: timestamp
└── updatedAt: timestamp
```

#### Attendance (Optimized Structure)

```
/institutions/{institutionId}/attendance/{attendanceId}/
├── Document ID: "{classId}_{YYYY-MM-DD}" (e.g., "cs101_2024-10-23")
├── classId: string
├── date: timestamp
├── markedBy: string (userId)
├── isSubmitted: boolean
    ├── createdAt: timestamp
    ├── updatedAt: timestamp
    └── /records/{studentId}/
    ├── status: string (present|absent|late|excused)
├── timestamp: timestamp (when status was recorded)
        ├── notes: string (optional)
    ├── markedBy: string (optional)
    └── markedAt: timestamp
```

## Key Optimizations

### 1. Composite Document IDs

**Attendance documents use composite IDs:**
```
attendanceId = "{classId}_{YYYY-MM-DD}"
Example: "cs101_2024-10-23"
```

**Benefits:**
- ✅ Deterministic - know the ID without querying
- ✅ Prevents duplicates - can't create two records for same class/date
- ✅ Fast access - direct document read instead of query
- ✅ Saves reads - 1 read instead of query + read

### 2. Subcollection for Records

Individual student attendance records are stored in a subcollection:

**Benefits:**
- ✅ Scalable - handles large class sizes (100+ students)
- ✅ Atomic updates - update individual students independently
- ✅ Efficient queries - only fetch records when needed
- ✅ No document size limits - parent doc stays small

### 3. Indexed Queries

Composite indexes enable efficient queries:

```dart
// Get all attendance for a class in date range
institutions/{id}/attendance
  .where('classId', '==', classId)
  .where('date', '>=', startDate)
  .where('date', '<=', endDate)
  .orderBy('date', 'desc')

// Get specific day's attendance (direct access)
institutions/{id}/attendance
  .doc('{classId}_{date}')
  .get()
```

## Security Rules

Role-based access control with multi-tenant support and super admin privileges:

```javascript
// Helper function to check if user is super admin
function isSuperAdmin() {
  return isAuthenticated() && getUserData().isSuperAdmin == true;
}

// Institution access requires active role OR super admin
function hasInstitutionAccess(institutionId) {
  return isAuthenticated() && (
    isSuperAdmin() ||
    (institutionId in getUserData().roles 
      && getUserData().roles[institutionId].isActive == true)
  );
}

// Users can read their own profile, super admin can read any profile
match /users/{userId} {
  allow read: if isAuthenticated() && (request.auth.uid == userId || isSuperAdmin());
}

// Institution access: super admin has access to all institutions
match /institutions/{institutionId} {
  allow read: if isSuperAdmin() || hasInstitutionAccess(institutionId);
  allow write: if canManageInstitution(institutionId);
  
  // Attendance can be marked by super admin, institution_admin, teacher, or class_rep
  match /attendance/{attendanceId} {
    allow read: if isSuperAdmin() || hasInstitutionAccess(institutionId);
    allow write: if canMarkAttendance(institutionId);
    
    match /records/{studentId} {
      allow read: if isSuperAdmin() || hasInstitutionAccess(institutionId);
      allow write: if canMarkAttendance(institutionId);
    }
  }
}
```

**Super Admin Privileges:**
- ✅ Read access to all user profiles
- ✅ Read/write access to all institutions and their subcollections
- ✅ Can mark attendance in any institution
- ✅ Can manage any institution (create, update, delete)
- ✅ Bypasses all institution-based access checks

## Example Documents

### Regular User Document

```json
{
  "uid": "firebase-auth-uid-123",
  "email": "john@example.com",
  "name": "John Doe",
  "isSuperAdmin": false,
  "roles": {
    "tech_university_2024": {
      "role": "institution_admin",
      "isActive": true,
      "joinedAt": "2024-01-15T10:00:00Z"
    },
    "business_school_2024": {
      "role": "class_rep",
      "assignedClassId": "mba101",
      "isActive": true,
      "joinedAt": "2024-02-20T14:30:00Z"
    }
  },
  "currentInstitutionId": "tech_university_2024",
  "createdAt": "2024-01-15T10:00:00Z",
  "updatedAt": "2024-03-10T09:15:00Z"
}
```

### Super Admin User Document

```json
{
  "uid": "firebase-auth-uid-456",
  "email": "superadmin@system.com",
  "name": "Super Administrator",
  "isSuperAdmin": true,
  "roles": {},
  "currentInstitutionId": null,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Notes:**
- Super admin has `isSuperAdmin: true` field
- Super admin doesn't require institution roles (roles map can be empty)
- Super admin has system-wide access to all institutions without explicit roles
- Super admin bypasses institution selection in the UI
- `currentInstitutionId` is optional for super admin (can be null)

### Attendance Parent Document

```json
{
  "classId": "cs101_2024",
  "date": "2024-10-23T00:00:00Z",
  "markedBy": "user123",
  "isSubmitted": true,
  "createdAt": "2024-10-23T09:00:00Z",
  "updatedAt": "2024-10-23T09:15:00Z"
}
```

### Attendance Record (Subcollection)

```json
{
  "status": "present",
  "timestamp": "2024-10-23T09:05:00Z",
  "notes": null,
  "markedBy": "user123",
  "markedAt": "2024-10-23T09:05:00Z"
}
```

## Query Patterns

### Common Queries

  ```dart
// 1. Get today's attendance for a class (FAST - direct access)
final attendanceId = '${classId}_${formatDate(DateTime.now())}';
final doc = await firestore
  .collection('institutions')
  .doc(institutionId)
  .collection('attendance')
  .doc(attendanceId)
  .get();

// 2. Get all records for today's attendance
final records = await firestore
  .collection('institutions')
  .doc(institutionId)
  .collection('attendance')
  .doc(attendanceId)
  .collection('records')
  .get();

// 3. Get attendance for date range (uses index)
final query = await firestore
  .collection('institutions')
  .doc(institutionId)
  .collection('attendance')
  .where('classId', isEqualTo: classId)
  .where('date', isGreaterThanOrEqualTo: startDate)
  .where('date', isLessThanOrEqualTo: endDate)
  .orderBy('date', descending: true)
  .get();

// 4. Check if attendance submitted (INSTANT)
final doc = await firestore
  .collection('institutions')
  .doc(institutionId)
  .collection('attendance')
  .doc(attendanceId)
  .get();
  
final isSubmitted = doc.exists && doc.data()['isSubmitted'] == true;
```

## Migration Notes

### From Old Structure

If migrating from the old flat structure:

1. Old structure stored all student records in parent document
2. New structure uses subcollections for scalability
3. Document IDs changed from date-only to composite IDs

### Migration Strategy

For development (with dummy data):
1. Delete existing attendance data
2. Use new structure going forward

For production:
1. Write new data in new format
2. Read from both formats (fallback to old)
3. Migrate old data via Cloud Function
4. Remove old format support

## Performance Characteristics

| Operation | Reads | Notes |
|-----------|-------|-------|
| Check if submitted | 1 | Direct document access |
| Get attendance metadata | 1 | Parent document only |
| Get all student records | 1 | Subcollection query |
| Get specific student | 1 | Direct document access |
| Submit attendance | 1 + N | Parent + N student records (batched) |

## Best Practices

1. **Always use composite IDs** for attendance documents
2. **Batch writes** when submitting attendance for multiple students
3. **Query by classId + date range** for reports (uses index)
4. **Check isSubmitted** before allowing edits
5. **Use subcollection** for individual records, not parent document
