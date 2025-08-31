import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

/// Abstract interface for remote student data source
abstract class StudentRemoteDataSource {
  /// Get all students for a class
  Future<List<StudentModel>> getStudents(String institutionId, String classId);

  /// Create a new student
  Future<void> createStudent(String institutionId, StudentModel newStudent);

  /// Update an existing student
  Future<void> updateStudent(String institutionId, StudentModel updatedStudent);

  /// Delete a student
  Future<void> deleteStudent(String institutionId, String studentId);
}

/// Implementation of StudentRemoteDataSource using Firebase
class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final FirebaseFirestore _firestore;

  StudentRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<List<StudentModel>> getStudents(
    String institutionId,
    String classId,
  ) async {
    final snapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('students')
        .where('classId', isEqualTo: classId)
        .get();
    return snapshot.docs
        .map((doc) => StudentModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> createStudent(String institutionId, StudentModel newStudent) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('students')
        .doc(newStudent.id)
        .set(newStudent.toJson());
  }

  @override
  Future<void> updateStudent(
    String institutionId,
    StudentModel updatedStudent,
  ) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('students')
        .doc(updatedStudent.id)
        .update(updatedStudent.toJson());
  }

  @override
  Future<void> deleteStudent(String institutionId, String studentId) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('students')
        .doc(studentId)
        .delete();
  }
}
