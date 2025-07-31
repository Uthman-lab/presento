# Firestore Security Rules Testing

This directory contains comprehensive tests for the Firestore security rules used in the Task Master TOT application.

## Overview

The security rules enforce:
- **Multi-tenancy**: Users can only access data within their own institution
- **Role-based access control**: Different permissions for admin, supervisor, class_rep, and stakeholder roles
- **Data isolation**: Proper separation between institutions and classes
- **Authentication requirements**: All access requires valid authentication

## Test Coverage

### Multi-tenancy and Institution Isolation
- ✅ Users can only access their own institution data
- ✅ Cross-institution access is denied
- ✅ Unauthenticated access is denied

### Role-Based Access Control
- ✅ Admin can access all data in their institution
- ✅ Supervisor can manage classes and students
- ✅ Class rep can manage attendance for assigned classes
- ✅ Stakeholder can read attendance for assigned classes

### Collection-Specific Access Rules
- ✅ Users collection access control
- ✅ Classes collection access control
- ✅ Students collection access control
- ✅ Attendance collection access control

### Edge Cases and Security Validation
- ✅ Cross-institution data access prevention
- ✅ Data integrity validation
- ✅ Role escalation attempt prevention

## Running Tests

### Prerequisites
1. Install dependencies:
   ```bash
   cd test
   npm install
   ```

2. Ensure Firebase CLI is installed:
   ```bash
   npm install -g firebase-tools
   ```

### Running Security Tests
```bash
# Run all security tests
npm run test:security

# Run tests in watch mode
npm run test:watch

# Run all tests
npm test
```

## Test Structure

The tests use the Firebase Rules Unit Testing library to simulate different user contexts and validate that the security rules work as expected.

### Test Scenarios

1. **Multi-tenancy Tests**
   - Verify users can only access their institution's data
   - Verify cross-institution access is blocked

2. **Role-based Tests**
   - Test admin permissions (full access)
   - Test supervisor permissions (class/student management)
   - Test class rep permissions (attendance management)
   - Test stakeholder permissions (read-only attendance)

3. **Collection-specific Tests**
   - Test access to users collection
   - Test access to classes collection
   - Test access to students collection
   - Test access to attendance collection

4. **Security Validation Tests**
   - Test data integrity requirements
   - Test role escalation prevention
   - Test authentication requirements

## Security Rules Features

### Helper Functions
- `isAuthenticated()`: Checks if user is authenticated
- `getUserRole()`: Gets user's role from Firestore
- `getUserInstitution()`: Gets user's institution ID
- `isInstitutionMember()`: Checks if user belongs to institution
- `isAssignedToClass()`: Checks if user is assigned to class

### Role Definitions
- **admin**: Full access to all data in their institution
- **supervisor**: Can manage classes and students
- **class_rep**: Can manage attendance for assigned classes
- **stakeholder**: Can read attendance for assigned classes

### Access Patterns
- **Read Access**: Based on role and institution membership
- **Write Access**: Based on role and specific permissions
- **Delete Access**: Restricted to admin and supervisor roles

## Continuous Integration

These tests should be run as part of the CI/CD pipeline to ensure security rules are properly validated before deployment.

## Deployment

After running tests successfully, deploy the security rules:

```bash
firebase deploy --only firestore:rules
```

## Monitoring

Monitor security rule performance and access patterns in the Firebase Console under Firestore > Rules. 