# Firebase Security Rules Implementation

This document describes the security rules implemented for Firestore and Firebase Storage to ensure data isolation and role-based access control.

## Firestore Security Rules

### Default Deny-All Policy
- All access is denied by default
- Only explicitly allowed operations are permitted
- This ensures maximum security

### Multi-Tenant Structure
- All data is organized under `/institutions/{institutionId}`
- Users can only access data from their own institution
- Cross-institution access is completely blocked

### Role-Based Access Control

#### Admin Role
- Full access to all data within their institution
- Can create, read, update, and delete users, classes, students
- Can manage attendance records
- Can upload institution logos

#### Supervisor Role
- Can read all data within their institution
- Can manage classes and students
- Can view attendance records
- Cannot manage users

#### Class Representative Role
- Can read classes and students
- Can mark attendance only for their assigned class
- Cannot manage users, classes, or students
- Can upload their own profile picture

#### Stakeholder Role
- Can read classes and students
- Can view attendance records
- Cannot modify any data
- Read-only access

### Authentication Requirements
- All operations require authentication
- User tokens must include `institutionId` and `role` claims
- Custom claims are set during user registration/login

## Firebase Storage Security Rules

### Default Deny-All Policy
- All file access is denied by default
- Only explicitly allowed operations are permitted

### File Structure
```
/institutions/{institutionId}/
├── users/{userId}/profile.jpg
├── students/{studentId}/profile.jpg
└── logo.jpg
```

### File Upload Restrictions
- Profile pictures: 5MB maximum
- Institution logos: 2MB maximum
- Only image files allowed
- File size and type validation

### Access Control
- Users can upload their own profile pictures
- Admins can upload institution logos
- Admins and supervisors can upload student photos
- All authenticated users can read photos within their institution

## Implementation Notes

### Custom Claims
User authentication tokens must include:
- `institutionId`: The user's institution ID
- `role`: User role (admin, supervisor, class_rep, stakeholder)
- `assignedClassId`: For class reps, their assigned class ID

### Security Best Practices
1. **Principle of Least Privilege**: Users only get access they need
2. **Data Isolation**: Complete separation between institutions
3. **Input Validation**: File size and type restrictions
4. **Audit Trail**: All operations are logged
5. **Regular Reviews**: Security rules should be reviewed regularly

### Testing Security Rules
Use Firebase Emulator Suite to test:
```bash
firebase emulators:start --only firestore,storage
```

### Deployment
Deploy rules to production:
```bash
firebase deploy --only firestore:rules,storage:rules
```

## Security Considerations

1. **Token Validation**: Always validate custom claims on the client
2. **Error Handling**: Handle permission denied errors gracefully
3. **User Experience**: Provide clear feedback when access is denied
4. **Monitoring**: Monitor for unusual access patterns
5. **Updates**: Keep security rules updated with new features 