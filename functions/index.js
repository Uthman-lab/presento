const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

/**
 * Cloud Function to create a user
 * Requires the caller to be a super admin
 * Creates both Firebase Auth user and Firestore document
 * Does not sign in the new user (preserves admin's session)
 */
exports.createUser = functions.https.onCall(async (data, context) => {
  // Verify the user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to create users.'
    );
  }

  const callerEmail = context.auth.token.email;
  const { email, password, name, isSuperAdmin = false, roles = {} } = data;

  console.log('=== CREATE USER DEBUG ===');
  console.log('Caller email from auth token:', callerEmail);
  console.log('New user email:', email);
  console.log('New user name:', name);
  console.log('New user isSuperAdmin:', isSuperAdmin);

  // Validate required fields
  if (!email || !password || !name) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'email, password, and name are required'
    );
  }

  try {
    // Get caller's user document to verify they are a super admin
    const callerDoc = await admin.firestore()
      .collection('users')
      .doc(callerEmail)
      .get();

    console.log('Caller doc exists:', callerDoc.exists);

    if (!callerDoc.exists) {
      console.log('ERROR: Caller document not found at path: users/' + callerEmail);
      throw new functions.https.HttpsError(
        'permission-denied',
        'Caller user document not found'
      );
    }

    const callerData = callerDoc.data();
    console.log('Caller data:', JSON.stringify(callerData, null, 2));
    console.log('Caller isSuperAdmin:', callerData.isSuperAdmin);

    if (!callerData.isSuperAdmin) {
      console.log('ERROR: Caller is not a super admin');
      throw new functions.https.HttpsError(
        'permission-denied',
        'Only super admins can create users'
      );
    }

    console.log('SUCCESS: Caller is verified as super admin');

    // Check if user already exists in Firebase Auth
    let userRecord;
    try {
      userRecord = await admin.auth().getUserByEmail(email);
      console.log('ERROR: User already exists in Firebase Auth with UID:', userRecord.uid);
      throw new functions.https.HttpsError(
        'already-exists',
        `User with email ${email} already exists`
      );
    } catch (authError) {
      if (authError instanceof functions.https.HttpsError) {
        throw authError;
      }
      // Check if the error is because user doesn't exist (error code 'auth/user-not-found')
      if (authError.code === 'auth/user-not-found') {
        // User doesn't exist, which is what we want - continue
        console.log('User does not exist in Firebase Auth, proceeding with creation');
      } else {
        // Some other error occurred
        console.error('Error checking if user exists:', authError);
        throw new functions.https.HttpsError(
          'internal',
          'Error checking if user exists',
          authError.message
        );
      }
    }

    // Check if user document already exists in Firestore
    const existingUserDoc = await admin.firestore()
      .collection('users')
      .doc(email)
      .get();

    if (existingUserDoc.exists) {
      console.log('ERROR: User document already exists in Firestore');
      throw new functions.https.HttpsError(
        'already-exists',
        `User with email ${email} already exists`
      );
    }

    // Create Firebase Auth user using Admin SDK (doesn't sign them in)
    console.log('Creating Firebase Auth user...');
    userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: name,
    });

    console.log('Firebase Auth user created with UID:', userRecord.uid);

    // Convert roles to the format expected by Firestore
    const rolesJson = {};
    for (const [institutionId, roleData] of Object.entries(roles)) {
      rolesJson[institutionId] = {
        role: roleData.role,
        assignedClassId: roleData.assignedClassId || null,
        isActive: roleData.isActive !== undefined ? roleData.isActive : true,
        joinedAt: roleData.joinedAt || new Date().toISOString(),
      };
    }

    // Create Firestore user document (using email as document ID)
    const now = new Date().toISOString();
    const userData = {
      email: email,
      name: name,
      isSuperAdmin: isSuperAdmin,
      roles: rolesJson,
      createdAt: now,
      updatedAt: now,
    };

    console.log('Creating Firestore user document...');
    await admin.firestore()
      .collection('users')
      .doc(email)
      .set(userData);

    console.log('Firestore user document created successfully');

    // Generate password reset link (user will need to reset password on first login)
    // Note: Admin SDK doesn't have sendPasswordResetEmail, so we generate the link
    // In production, you might want to send this link via a custom email service
    console.log('Generating password reset link...');
    const passwordResetLink = await admin.auth().generatePasswordResetLink(email);
    console.log('Password reset link generated (not sent via email - implement custom email service if needed)');

    // Return created user data (include uid for the client)
    return {
      success: true,
      message: 'User created successfully',
      user: {
        ...userData,
        uid: userRecord.uid,
      },
    };

  } catch (error) {
    // Re-throw HttpsError as-is
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    // Handle other errors
    console.error('Error creating user:', error);
    throw new functions.https.HttpsError(
      'internal',
      'An error occurred while creating the user',
      error.message
    );
  }
});

/**
 * Cloud Function to update a user
 * Requires the caller to be a super admin
 * Allows partial updates (only provided fields are updated)
 */
exports.updateUser = functions.https.onCall(async (data, context) => {
  // Verify the user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to update users.'
    );
  }

  const callerEmail = context.auth.token.email;
  const { userId, name, isSuperAdmin, roles } = data;

  console.log('=== UPDATE USER DEBUG ===');
  console.log('Caller email from auth token:', callerEmail);
  console.log('Target user email (userId):', userId);
  console.log('Update name:', name);
  console.log('Update isSuperAdmin:', isSuperAdmin);
  console.log('Update roles:', JSON.stringify(roles, null, 2));

  // Validate required fields
  if (!userId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'userId (email) is required'
    );
  }

  try {
    // Get caller's user document to verify they are a super admin
    const callerDoc = await admin.firestore()
      .collection('users')
      .doc(callerEmail)
      .get();

    console.log('Caller doc exists:', callerDoc.exists);

    if (!callerDoc.exists) {
      console.log('ERROR: Caller document not found at path: users/' + callerEmail);
      throw new functions.https.HttpsError(
        'permission-denied',
        'Caller user document not found'
      );
    }

    const callerData = callerDoc.data();
    console.log('Caller data:', JSON.stringify(callerData, null, 2));
    console.log('Caller isSuperAdmin:', callerData.isSuperAdmin);

    if (!callerData.isSuperAdmin) {
      console.log('ERROR: Caller is not a super admin');
      throw new functions.https.HttpsError(
        'permission-denied',
        'Only super admins can update users'
      );
    }

    console.log('SUCCESS: Caller is verified as super admin');

    // Get the user to be updated
    // userId is the email (document ID)
    const userToUpdateDoc = admin.firestore().collection('users').doc(userId);
    const userToUpdateSnapshot = await userToUpdateDoc.get();

    if (!userToUpdateSnapshot.exists) {
      console.log('ERROR: User document not found for email:', userId);
      throw new functions.https.HttpsError(
        'not-found',
        `User not found with email: ${userId}`
      );
    }

    const userToUpdateData = userToUpdateSnapshot.data();
    console.log('Target user document data:', JSON.stringify(userToUpdateData, null, 2));

    // Build update data (only include fields that are provided)
    const updateData = {
      updatedAt: new Date().toISOString(),
    };

    if (name !== undefined && name !== null) {
      updateData.name = name;
    }

    if (isSuperAdmin !== undefined && isSuperAdmin !== null) {
      updateData.isSuperAdmin = isSuperAdmin;
    }

    if (roles !== undefined && roles !== null) {
      // Convert roles to the format expected by Firestore
      const rolesJson = {};
      for (const [institutionId, roleData] of Object.entries(roles)) {
        rolesJson[institutionId] = {
          role: roleData.role,
          assignedClassId: roleData.assignedClassId || null,
          isActive: roleData.isActive !== undefined ? roleData.isActive : true,
          joinedAt: roleData.joinedAt || new Date().toISOString(),
        };
      }
      updateData.roles = rolesJson;
    }

    console.log('Updating user document with data:', JSON.stringify(updateData, null, 2));

    // Update Firestore document
    await userToUpdateDoc.update(updateData);

    console.log('User document updated successfully');

    // Fetch the updated user document
    const updatedUserSnapshot = await userToUpdateDoc.get();
    const updatedUserData = updatedUserSnapshot.data();

    // Get uid from Firebase Auth if available
    let uid = null;
    try {
      const userRecord = await admin.auth().getUserByEmail(userId);
      uid = userRecord.uid;
      console.log('Found UID in Firebase Auth:', uid);
    } catch (authError) {
      console.log('User not found in Firebase Auth (this is okay for Firestore-only users):', authError.message);
    }

    // Return updated user data (include uid for the client)
    return {
      success: true,
      message: 'User updated successfully',
      user: {
        ...updatedUserData,
        uid: uid,
      },
    };

  } catch (error) {
    // Re-throw HttpsError as-is
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    // Handle other errors
    console.error('Error updating user:', error);
    throw new functions.https.HttpsError(
      'internal',
      'An error occurred while updating the user',
      error.message
    );
  }
});

/**
 * Cloud Function to delete a user
 * Requires the caller to be a super admin
 * Prevents deletion of the last remaining super admin
 */
exports.deleteUser = functions.https.onCall(async (data, context) => {
  // Verify the user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to delete users.'
    );
  }

  const callerEmail = context.auth.token.email;
  const userEmail = data.userId;  // Actually an email

  console.log('=== DELETE USER DEBUG ===');
  console.log('Caller email from auth token:', callerEmail);
  console.log('Target user email:', userEmail);

  if (!userEmail) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'userId (email) is required'
    );
  }

  try {
    // Get caller's user document to verify they are a super admin
    const callerDoc = await admin.firestore()
      .collection('users')
      .doc(callerEmail)
      .get();

    console.log('Caller doc exists:', callerDoc.exists);
    
    if (!callerDoc.exists) {
      console.log('ERROR: Caller document not found at path: users/' + callerEmail);
      throw new functions.https.HttpsError(
        'permission-denied',
        'Caller user document not found'
      );
    }

    const callerData = callerDoc.data();
    console.log('Caller data:', JSON.stringify(callerData, null, 2));
    console.log('Caller isSuperAdmin:', callerData.isSuperAdmin);
    console.log('Caller email in doc:', callerData.email);
    
    if (!callerData.isSuperAdmin) {
      console.log('ERROR: Caller is not a super admin');
      throw new functions.https.HttpsError(
        'permission-denied',
        'Only super admins can delete users'
      );
    }

    console.log('SUCCESS: Caller is verified as super admin');

    // Get the user to be deleted
    // userId should be an email (document ID)
    const userToDeleteDoc = admin.firestore().collection('users').doc(userEmail);
    const userToDeleteSnapshot = await userToDeleteDoc.get();

    if (!userToDeleteSnapshot.exists) {
      console.log('ERROR: User document not found for email:', userEmail);
      throw new functions.https.HttpsError(
        'not-found',
        `User not found with email: ${userEmail}`
      );
    }

    const userToDeleteData = userToDeleteSnapshot.data();
    console.log('Target user document data:', JSON.stringify(userToDeleteData, null, 2));

    // Get the uid from Firebase Auth for deletion
    let userToDeleteUid = null;
    console.log('Looking up user in Firebase Auth by email:', userEmail);

    try {
      const userRecord = await admin.auth().getUserByEmail(userEmail);
      userToDeleteUid = userRecord.uid;
      console.log('Found UID in Firebase Auth:', userToDeleteUid);
    } catch (authError) {
      console.log('User not found in Firebase Auth:', authError.message);
      // User doesn't exist in Firebase Auth, so just delete the Firestore document
      console.log('Deleting Firestore document only (no Firebase Auth account exists)');
      await userToDeleteDoc.delete();
      return {
        success: true,
        message: 'User deleted successfully (Firestore only - no Firebase Auth account found)'
      };
    }

    // Prevent deletion of the last remaining super admin
    if (userToDeleteData.isSuperAdmin) {
      const allSuperAdminsSnapshot = await admin.firestore()
        .collection('users')
        .where('isSuperAdmin', '==', true)
        .get();

      if (allSuperAdminsSnapshot.size <= 1) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'Cannot delete the last remaining super admin'
        );
      }
    }

    // Delete the Firebase Auth user
    await admin.auth().deleteUser(userToDeleteUid);

    // Delete the Firestore document
    await userToDeleteDoc.delete();

    return {
      success: true,
      message: 'User deleted successfully'
    };

  } catch (error) {
    // Re-throw HttpsError as-is
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    // Handle other errors
    console.error('Error deleting user:', error);
    throw new functions.https.HttpsError(
      'internal',
      'An error occurred while deleting the user',
      error.message
    );
  }
});
