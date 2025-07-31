import { initializeTestEnvironment, RulesTestEnvironment } from '@firebase/rules-unit-testing';
import { doc, getDoc, setDoc, updateDoc, deleteDoc, collection, query, getDocs } from 'firebase/firestore';
import fs from 'fs';

// Test environment setup
let testEnv: RulesTestEnvironment;

beforeAll(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: 'test-project',
    firestore: {
      rules: fs.readFileSync('firestore.rules', 'utf8'),
    },
  });
});

afterAll(async () => {
  await testEnv.cleanup();
});

beforeEach(async () => {
  await testEnv.clearFirestore();
});

describe('Firestore Security Rules', () => {
  describe('Multi-tenancy and Institution Isolation', () => {
    test('should allow users to access only their institution data', async () => {
      const db = testEnv.authenticatedContext('user1', {
        institutionId: 'institution1',
        role: 'admin',
      }).firestore();

      // Should succeed - user accessing their own institution
      await expect(
        setDoc(doc(db, 'institutions/institution1'), {
          name: 'Test Institution',
          createdAt: new Date(),
        })
      ).resolves.toBeUndefined();

      // Should fail - user trying to access different institution
      await expect(
        setDoc(doc(db, 'institutions/institution2'), {
          name: 'Other Institution',
          createdAt: new Date(),
        })
      ).rejects.toThrow();
    });

    test('should deny unauthenticated access', async () => {
      const db = testEnv.unauthenticatedContext().firestore();

      await expect(
        getDoc(doc(db, 'institutions/institution1'))
      ).rejects.toThrow();
    });
  });

  describe('Role-Based Access Control', () => {
    test('should allow admin to access all data in their institution', async () => {
      const db = testEnv.authenticatedContext('admin1', {
        institutionId: 'institution1',
        role: 'admin',
      }).firestore();

      // Admin should be able to read/write all collections
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1'), {
          name: 'Test Class',
          institutionId: 'institution1',
        })
      ).resolves.toBeUndefined();

      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1/students/student1'), {
          name: 'Test Student',
          institutionId: 'institution1',
          classId: 'class1',
        })
      ).resolves.toBeUndefined();
    });

    test('should allow supervisor to manage classes and students', async () => {
      const db = testEnv.authenticatedContext('supervisor1', {
        institutionId: 'institution1',
        role: 'supervisor',
      }).firestore();

      // Supervisor should be able to manage classes
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1'), {
          name: 'Test Class',
          institutionId: 'institution1',
        })
      ).resolves.toBeUndefined();

      // Supervisor should be able to manage students
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1/students/student1'), {
          name: 'Test Student',
          institutionId: 'institution1',
          classId: 'class1',
        })
      ).resolves.toBeUndefined();
    });

    test('should allow class rep to manage attendance for assigned classes', async () => {
      const db = testEnv.authenticatedContext('classrep1', {
        institutionId: 'institution1',
        role: 'class_rep',
        assignedClasses: ['class1'],
      }).firestore();

      // Class rep should be able to create attendance records
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1/attendance/2024-01-01'), {
          classId: 'class1',
          institutionId: 'institution1',
          date: '2024-01-01',
          records: [],
        })
      ).resolves.toBeUndefined();

      // Class rep should not be able to access unassigned classes
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class2/attendance/2024-01-01'), {
          classId: 'class2',
          institutionId: 'institution1',
          date: '2024-01-01',
          records: [],
        })
      ).rejects.toThrow();
    });

    test('should allow stakeholder to read attendance for assigned classes', async () => {
      const db = testEnv.authenticatedContext('stakeholder1', {
        institutionId: 'institution1',
        role: 'stakeholder',
        assignedClasses: ['class1'],
      }).firestore();

      // Stakeholder should be able to read attendance
      await expect(
        getDoc(doc(db, 'institutions/institution1/classes/class1/attendance/2024-01-01'))
      ).resolves.toBeDefined();

      // Stakeholder should not be able to write attendance
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1/attendance/2024-01-01'), {
          classId: 'class1',
          institutionId: 'institution1',
          date: '2024-01-01',
          records: [],
        })
      ).rejects.toThrow();
    });
  });

  describe('Collection-Specific Access Rules', () => {
    test('should enforce proper access to users collection', async () => {
      const adminDb = testEnv.authenticatedContext('admin1', {
        institutionId: 'institution1',
        role: 'admin',
      }).firestore();

      const userDb = testEnv.authenticatedContext('user1', {
        institutionId: 'institution1',
        role: 'class_rep',
      }).firestore();

      // Admin should be able to read/write users
      await expect(
        setDoc(doc(adminDb, 'users/user1'), {
          name: 'Test User',
          role: 'class_rep',
          institutionId: 'institution1',
        })
      ).resolves.toBeUndefined();

      // Regular user should be able to read their own profile
      await expect(
        getDoc(doc(userDb, 'users/user1'))
      ).resolves.toBeDefined();

      // Regular user should not be able to write other users
      await expect(
        setDoc(doc(userDb, 'users/user2'), {
          name: 'Other User',
          role: 'class_rep',
          institutionId: 'institution1',
        })
      ).rejects.toThrow();
    });

    test('should enforce proper access to classes collection', async () => {
      const supervisorDb = testEnv.authenticatedContext('supervisor1', {
        institutionId: 'institution1',
        role: 'supervisor',
      }).firestore();

      const classRepDb = testEnv.authenticatedContext('classrep1', {
        institutionId: 'institution1',
        role: 'class_rep',
        assignedClasses: ['class1'],
      }).firestore();

      // Supervisor should be able to manage classes
      await expect(
        setDoc(doc(supervisorDb, 'institutions/institution1/classes/class1'), {
          name: 'Test Class',
          institutionId: 'institution1',
        })
      ).resolves.toBeUndefined();

      // Class rep should be able to read assigned classes
      await expect(
        getDoc(doc(classRepDb, 'institutions/institution1/classes/class1'))
      ).resolves.toBeDefined();

      // Class rep should not be able to create classes
      await expect(
        setDoc(doc(classRepDb, 'institutions/institution1/classes/class2'), {
          name: 'New Class',
          institutionId: 'institution1',
        })
      ).rejects.toThrow();
    });

    test('should enforce proper access to students collection', async () => {
      const supervisorDb = testEnv.authenticatedContext('supervisor1', {
        institutionId: 'institution1',
        role: 'supervisor',
      }).firestore();

      const classRepDb = testEnv.authenticatedContext('classrep1', {
        institutionId: 'institution1',
        role: 'class_rep',
        assignedClasses: ['class1'],
      }).firestore();

      // Supervisor should be able to manage students
      await expect(
        setDoc(doc(supervisorDb, 'institutions/institution1/classes/class1/students/student1'), {
          name: 'Test Student',
          institutionId: 'institution1',
          classId: 'class1',
        })
      ).resolves.toBeUndefined();

      // Class rep should be able to read students in assigned classes
      await expect(
        getDoc(doc(classRepDb, 'institutions/institution1/classes/class1/students/student1'))
      ).resolves.toBeDefined();

      // Class rep should not be able to create students
      await expect(
        setDoc(doc(classRepDb, 'institutions/institution1/classes/class1/students/student2'), {
          name: 'New Student',
          institutionId: 'institution1',
          classId: 'class1',
        })
      ).rejects.toThrow();
    });

    test('should enforce proper access to attendance collection', async () => {
      const classRepDb = testEnv.authenticatedContext('classrep1', {
        institutionId: 'institution1',
        role: 'class_rep',
        assignedClasses: ['class1'],
      }).firestore();

      const stakeholderDb = testEnv.authenticatedContext('stakeholder1', {
        institutionId: 'institution1',
        role: 'stakeholder',
        assignedClasses: ['class1'],
      }).firestore();

      // Class rep should be able to create attendance records
      await expect(
        setDoc(doc(classRepDb, 'institutions/institution1/classes/class1/attendance/2024-01-01'), {
          classId: 'class1',
          institutionId: 'institution1',
          date: '2024-01-01',
          records: [],
        })
      ).resolves.toBeUndefined();

      // Stakeholder should be able to read attendance records
      await expect(
        getDoc(doc(stakeholderDb, 'institutions/institution1/classes/class1/attendance/2024-01-01'))
      ).resolves.toBeDefined();

      // Stakeholder should not be able to create attendance records
      await expect(
        setDoc(doc(stakeholderDb, 'institutions/institution1/classes/class1/attendance/2024-01-02'), {
          classId: 'class1',
          institutionId: 'institution1',
          date: '2024-01-02',
          records: [],
        })
      ).rejects.toThrow();
    });
  });

  describe('Edge Cases and Security Validation', () => {
    test('should prevent cross-institution data access', async () => {
      const user1Db = testEnv.authenticatedContext('user1', {
        institutionId: 'institution1',
        role: 'admin',
      }).firestore();

      const user2Db = testEnv.authenticatedContext('user2', {
        institutionId: 'institution2',
        role: 'admin',
      }).firestore();

      // User from institution1 should not access institution2 data
      await expect(
        getDoc(doc(user1Db, 'institutions/institution2'))
      ).rejects.toThrow();

      // User from institution2 should not access institution1 data
      await expect(
        getDoc(doc(user2Db, 'institutions/institution1'))
      ).rejects.toThrow();
    });

    test('should validate data integrity', async () => {
      const db = testEnv.authenticatedContext('admin1', {
        institutionId: 'institution1',
        role: 'admin',
      }).firestore();

      // Should enforce required fields
      await expect(
        setDoc(doc(db, 'institutions/institution1/classes/class1'), {
          // Missing required fields
        })
      ).rejects.toThrow();
    });

    test('should handle role escalation attempts', async () => {
      const classRepDb = testEnv.authenticatedContext('classrep1', {
        institutionId: 'institution1',
        role: 'class_rep',
        assignedClasses: ['class1'],
      }).firestore();

      // Class rep should not be able to escalate to admin role
      await expect(
        setDoc(doc(classRepDb, 'users/classrep1'), {
          name: 'Class Rep',
          role: 'admin', // Attempting role escalation
          institutionId: 'institution1',
        })
      ).rejects.toThrow();
    });
  });
}); 