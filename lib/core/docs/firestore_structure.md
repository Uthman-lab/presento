# Multi-Tenant Firestore Structure

This document describes the Firestore database structure for the Task Master Attendance System, implementing a multi-tenant architecture where each institution's data is isolated.

## Database Structure

### Root Collections

```
/institutions/{institutionId}/
├── name: string
├── description: string (optional)
├── address: string (optional)
├── phone: string (optional)
├── email: string (optional)
├── website: string (optional)
├── logoUrl: string (optional)
├── createdAt: timestamp
├── updatedAt: timestamp
├── /users/{userId}/
│   ├── email: string
│   ├── name: string
│   ├── role: string (admin, supervisor, class_rep, stakeholder)
│   ├── profilePictureUrl: string (optional)
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
├── /classes/{classId}/
│   ├── name: string
│   ├── description: string (optional)
│   ├── roomNumber: string (optional)
│   ├── schedule: string (optional)
│   ├── teacherName: string (optional)
│   ├── maxStudents: number
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
├── /students/{studentId}/
│   ├── studentId: string (student ID number)
│   ├── name: string
│   ├── classId: string (reference to class)
│   ├── email: string (optional)
│   ├── phone: string (optional)
│   ├── address: string (optional)
│   ├── profilePictureUrl: string (optional)
│   ├── dateOfBirth: timestamp
│   ├── emergencyContact: string (optional)
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
└── /attendance/{date}/
    ├── classId: string (reference to class)
    ├── markedBy: string (user ID who marked attendance)
    ├── createdAt: timestamp
    ├── updatedAt: timestamp
    └── /records/{studentId}/
        ├── status: string (present, absent, late, excused)
        ├── notes: string (optional)
        ├── markedAt: timestamp
        └── updatedAt: timestamp
```

## Multi-Tenant Security Rules

### Basic Structure
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Ensure users can only access their institution's data
    match /institutions/{institutionId} {
      allow read, write: if request.auth != null && 
        request.auth.token.institutionId == institutionId;
      
      // Nested collections inherit the parent's security
      match /{document=**} {
        allow read, write: if request.auth != null && 
          request.auth.token.institutionId == institutionId;
      }
    }
  }
}
```

### Role-Based Access Control
```javascript
// Admin can access everything in their institution
match /institutions/{institutionId} {
  allow read, write: if request.auth != null && 
    request.auth.token.institutionId == institutionId &&
    request.auth.token.role == 'admin';
}

// Class Rep can only mark attendance for their assigned class
match /institutions/{institutionId}/attendance/{date}/records/{studentId} {
  allow write: if request.auth != null && 
    request.auth.token.institutionId == institutionId &&
    request.auth.token.role == 'class_rep' &&
    request.auth.token.assignedClassId == resource.data.classId;
}
```

## Data Isolation

1. **Institution-Level Isolation**: All data is nested under `/institutions/{institutionId}`
2. **User Authentication**: Users are authenticated with Firebase Auth and have custom claims for `institutionId` and `role`
3. **Security Rules**: Firestore security rules enforce access control at the institution level
4. **No Cross-Institution Access**: Users cannot access data from other institutions

## Benefits

1. **Data Security**: Complete isolation between institutions
2. **Scalability**: Each institution's data is independent
3. **Compliance**: Meets data privacy requirements
4. **Flexibility**: Easy to add new institutions without affecting existing ones
5. **Cost Efficiency**: Pay only for the data you use

## Implementation Notes

- All queries must include the `institutionId` filter
- User authentication tokens must include `institutionId` and `role` claims
- Security rules are enforced at the Firestore level
- Data models in the app reflect this structure
- Repository implementations handle the multi-tenant logic 