part of '../core.dart';

/// Seeds sample institutions into Firestore database
/// Only runs in debug mode to prevent accidental production seeding
Future<void> seedInstitutions() async {
  if (!kDebugMode) return;

  print('🌱 Starting institution seeding...');

  try {
    final firestore = FirebaseFirestore.instance;

    // Sample institutions data
    final institutions = [
      {
        'id': 'tech_university_2024',
        'name': 'Tech University 2024',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'id': 'business_school_2024',
        'name': 'Business School 2024',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'id': 'science_academy_2024',
        'name': 'Science Academy 2024',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'id': 'engineering_college_2024',
        'name': 'Engineering College 2024',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'id': 'arts_institute_2024',
        'name': 'Arts Institute 2024',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    // Sample classes data for each institution
    final classesData = {
      'tech_university_2024': [
        {
          'id': 'cs101',
          'name': 'CS101 - Introduction to Programming',
          'description': 'Fundamentals of computer programming',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'cs201',
          'name': 'CS201 - Data Structures',
          'description': 'Advanced programming concepts and data structures',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'cs301',
          'name': 'CS301 - Software Engineering',
          'description': 'Software development methodologies and practices',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ],
      'business_school_2024': [
        {
          'id': 'mba101',
          'name': 'MBA101 - Business Fundamentals',
          'description': 'Core business concepts and principles',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'mba201',
          'name': 'MBA201 - Strategic Management',
          'description': 'Strategic planning and organizational management',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'mba301',
          'name': 'MBA301 - Financial Analysis',
          'description': 'Financial modeling and investment analysis',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ],
      'science_academy_2024': [
        {
          'id': 'bio101',
          'name': 'BIO101 - General Biology',
          'description': 'Introduction to biological sciences',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'chem101',
          'name': 'CHEM101 - General Chemistry',
          'description': 'Fundamental chemistry principles',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'phy101',
          'name': 'PHY101 - General Physics',
          'description': 'Basic physics concepts and laws',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ],
      'engineering_college_2024': [
        {
          'id': 'me101',
          'name': 'ME101 - Mechanical Engineering Basics',
          'description': 'Introduction to mechanical engineering',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'ee101',
          'name': 'EE101 - Electrical Engineering Fundamentals',
          'description': 'Basic electrical engineering concepts',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'ce101',
          'name': 'CE101 - Civil Engineering Principles',
          'description': 'Introduction to civil engineering',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ],
      'arts_institute_2024': [
        {
          'id': 'art101',
          'name': 'ART101 - Drawing Fundamentals',
          'description': 'Basic drawing techniques and principles',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'music101',
          'name': 'MUSIC101 - Music Theory',
          'description': 'Fundamental music theory and composition',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'id': 'drama101',
          'name': 'DRAMA101 - Acting Techniques',
          'description': 'Basic acting methods and performance skills',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ],
    };

    // Sample students data for each class
    final studentsData = {
      'cs101': [
        {
          'studentId': 'STU001',
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'phone': '+1234567890',
        },
        {
          'studentId': 'STU002',
          'name': 'Jane Smith',
          'email': 'jane.smith@example.com',
          'phone': '+1234567891',
        },
        {
          'studentId': 'STU003',
          'name': 'Mike Johnson',
          'email': 'mike.johnson@example.com',
          'phone': '+1234567892',
        },
        {
          'studentId': 'STU004',
          'name': 'Sarah Wilson',
          'email': 'sarah.wilson@example.com',
          'phone': '+1234567893',
        },
        {
          'studentId': 'STU005',
          'name': 'David Brown',
          'email': 'david.brown@example.com',
          'phone': '+1234567894',
        },
        {
          'studentId': 'STU006',
          'name': 'Emily Davis',
          'email': 'emily.davis@example.com',
          'phone': '+1234567895',
        },
        {
          'studentId': 'STU007',
          'name': 'Chris Miller',
          'email': 'chris.miller@example.com',
          'phone': '+1234567896',
        },
        {
          'studentId': 'STU008',
          'name': 'Lisa Garcia',
          'email': 'lisa.garcia@example.com',
          'phone': '+1234567897',
        },
        {
          'studentId': 'STU009',
          'name': 'Tom Anderson',
          'email': 'tom.anderson@example.com',
          'phone': '+1234567898',
        },
        {
          'studentId': 'STU010',
          'name': 'Amy Taylor',
          'email': 'amy.taylor@example.com',
          'phone': '+1234567899',
        },
      ],
      'cs201': [
        {
          'studentId': 'STU011',
          'name': 'Alex Rodriguez',
          'email': 'alex.rodriguez@example.com',
          'phone': '+1234567800',
        },
        {
          'studentId': 'STU012',
          'name': 'Maria Lopez',
          'email': 'maria.lopez@example.com',
          'phone': '+1234567801',
        },
        {
          'studentId': 'STU013',
          'name': 'James Wilson',
          'email': 'james.wilson@example.com',
          'phone': '+1234567802',
        },
        {
          'studentId': 'STU014',
          'name': 'Jennifer Lee',
          'email': 'jennifer.lee@example.com',
          'phone': '+1234567803',
        },
        {
          'studentId': 'STU015',
          'name': 'Robert Martinez',
          'email': 'robert.martinez@example.com',
          'phone': '+1234567804',
        },
        {
          'studentId': 'STU016',
          'name': 'Michelle Clark',
          'email': 'michelle.clark@example.com',
          'phone': '+1234567805',
        },
        {
          'studentId': 'STU017',
          'name': 'Kevin Lewis',
          'email': 'kevin.lewis@example.com',
          'phone': '+1234567806',
        },
        {
          'studentId': 'STU018',
          'name': 'Nicole Walker',
          'email': 'nicole.walker@example.com',
          'phone': '+1234567807',
        },
        {
          'studentId': 'STU019',
          'name': 'Daniel Hall',
          'email': 'daniel.hall@example.com',
          'phone': '+1234567808',
        },
        {
          'studentId': 'STU020',
          'name': 'Stephanie Young',
          'email': 'stephanie.young@example.com',
          'phone': '+1234567809',
        },
      ],
      'cs301': [
        {
          'studentId': 'STU021',
          'name': 'Matthew Allen',
          'email': 'matthew.allen@example.com',
          'phone': '+1234567810',
        },
        {
          'studentId': 'STU022',
          'name': 'Rachel King',
          'email': 'rachel.king@example.com',
          'phone': '+1234567811',
        },
        {
          'studentId': 'STU023',
          'name': 'Andrew Wright',
          'email': 'andrew.wright@example.com',
          'phone': '+1234567812',
        },
        {
          'studentId': 'STU024',
          'name': 'Jessica Scott',
          'email': 'jessica.scott@example.com',
          'phone': '+1234567813',
        },
        {
          'studentId': 'STU025',
          'name': 'Ryan Green',
          'email': 'ryan.green@example.com',
          'phone': '+1234567814',
        },
        {
          'studentId': 'STU026',
          'name': 'Amanda Adams',
          'email': 'amanda.adams@example.com',
          'phone': '+1234567815',
        },
        {
          'studentId': 'STU027',
          'name': 'Brandon Baker',
          'email': 'brandon.baker@example.com',
          'phone': '+1234567816',
        },
        {
          'studentId': 'STU028',
          'name': 'Samantha Nelson',
          'email': 'samantha.nelson@example.com',
          'phone': '+1234567817',
        },
        {
          'studentId': 'STU029',
          'name': 'Justin Carter',
          'email': 'justin.carter@example.com',
          'phone': '+1234567818',
        },
        {
          'studentId': 'STU030',
          'name': 'Megan Mitchell',
          'email': 'megan.mitchell@example.com',
          'phone': '+1234567819',
        },
      ],
    };

    // Generate similar student data for other classes
    final allStudentsData = <String, List<Map<String, String>>>{};

    // Generate students for all classes
    for (final institutionId in classesData.keys) {
      for (final classData in classesData[institutionId]!) {
        final classId = classData['id'] as String;
        if (!allStudentsData.containsKey(classId)) {
          allStudentsData[classId] = [];
          for (int i = 1; i <= 15; i++) {
            final studentNum =
                (institutions.indexOf(
                      institutions.firstWhere(
                        (inst) => inst['id'] == institutionId,
                      ),
                    ) *
                    30) +
                (classesData[institutionId]!.indexOf(classData) * 15) +
                i;
            allStudentsData[classId]!.add({
              'studentId': 'STU${studentNum.toString().padLeft(3, '0')}',
              'name': 'Student $studentNum',
              'email': 'student$studentNum@example.com',
              'phone': '+1234567${studentNum.toString().padLeft(3, '0')}',
            });
          }
        }
      }
    }

    // Merge with existing students data
    allStudentsData.addAll(studentsData);

    // Seed institutions
    print('📚 Seeding ${institutions.length} institutions...');
    for (int i = 0; i < institutions.length; i++) {
      final institution = institutions[i];
      print(
        '  Seeding institution ${i + 1}/${institutions.length}: ${institution['name']}',
      );

      // Check if institution already exists
      final institutionDoc = await firestore
          .collection(AppConstants.institutionsCollection)
          .doc(institution['id'] as String)
          .get();

      if (!institutionDoc.exists) {
        await firestore
            .collection(AppConstants.institutionsCollection)
            .doc(institution['id'] as String)
            .set(institution);
      }

      // Seed classes for this institution
      final classes = classesData[institution['id'] as String]!;
      print('    📖 Seeding ${classes.length} classes...');

      for (final classData in classes) {
        final classId = classData['id'] as String;

        // Check if class already exists
        final classDoc = await firestore
            .collection(AppConstants.institutionsCollection)
            .doc(institution['id'] as String)
            .collection('classes')
            .doc(classId)
            .get();

        if (!classDoc.exists) {
          await firestore
              .collection(AppConstants.institutionsCollection)
              .doc(institution['id'] as String)
              .collection('classes')
              .doc(classId)
              .set(classData);
        }

        // Seed students for this class
        final students = allStudentsData[classId] ?? [];
        print(
          '      👥 Seeding ${students.length} students for class $classId...',
        );

        for (final studentData in students) {
          final studentId = studentData['studentId']!;

          // Check if student already exists
          final studentDoc = await firestore
              .collection(AppConstants.institutionsCollection)
              .doc(institution['id'] as String)
              .collection('students')
              .doc(studentId)
              .get();

          if (!studentDoc.exists) {
            final studentRecord = {
              'studentId': studentId,
              'name': studentData['name']!,
              'classId': classId,
              'email': studentData['email']!,
              'phone': studentData['phone']!,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            };

            await firestore
                .collection(AppConstants.institutionsCollection)
                .doc(institution['id'] as String)
                .collection('students')
                .doc(studentId)
                .set(studentRecord);
          }
        }

        // Seed attendance records for the past week
        print('      📅 Seeding attendance records for the past week...');
        final now = DateTime.now();
        for (int dayOffset = 6; dayOffset >= 0; dayOffset--) {
          final date = now.subtract(Duration(days: dayOffset));
          final dateStr =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
          final attendanceId = '${classId}_$dateStr';

          // Check if attendance record already exists
          final attendanceDoc = await firestore
              .collection(AppConstants.institutionsCollection)
              .doc(institution['id'] as String)
              .collection('attendance')
              .doc(attendanceId)
              .get();

          if (!attendanceDoc.exists) {
            // Create attendance parent document
            final attendanceData = {
              'classId': classId,
              'date': Timestamp.fromDate(date),
              'markedBy': 'admin_user_id',
              'isSubmitted': true,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            };

            await firestore
                .collection(AppConstants.institutionsCollection)
                .doc(institution['id'] as String)
                .collection('attendance')
                .doc(attendanceId)
                .set(attendanceData);

            // Create attendance records for each student
            final students = allStudentsData[classId] ?? [];
            for (final studentData in students) {
              final studentId = studentData['studentId']!;

              // Random attendance status (80% present, 15% absent, 3% late, 2% excused)
              final random = Random().nextDouble();
              String status;
              if (random < 0.8) {
                status = 'present';
              } else if (random < 0.95) {
                status = 'absent';
              } else if (random < 0.98) {
                status = 'late';
              } else {
                status = 'excused';
              }

              final recordData = {
                'status': status,
                'timestamp': FieldValue.serverTimestamp(),
                'notes': status == 'excused' ? 'Medical appointment' : null,
                'markedBy': 'admin_user_id',
                'markedAt': FieldValue.serverTimestamp(),
              };

              await firestore
                  .collection(AppConstants.institutionsCollection)
                  .doc(institution['id'] as String)
                  .collection('attendance')
                  .doc(attendanceId)
                  .collection('records')
                  .doc(studentId)
                  .set(recordData);
            }
          }
        }
      }
    }

    print('✅ Institution seeding completed successfully!');
    print('📊 Summary:');
    print('  - ${institutions.length} institutions seeded');
    print(
      '  - ${institutions.fold(0, (sum, inst) => sum + classesData[inst['id'] as String]!.length)} classes seeded',
    );
    print(
      '  - ${allStudentsData.values.fold(0, (sum, students) => sum + students.length)} students seeded',
    );
    print(
      '  - ${institutions.fold(0, (sum, inst) => sum + classesData[inst['id'] as String]!.length * 7)} attendance records seeded',
    );
  } catch (e) {
    print('❌ Error during seeding: $e');
    rethrow;
  }
}
