import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_model.dart';

/// Abstract interface for remote class data source
abstract class ClassRemoteDataSource {
  /// Get all classes for an institution
  Future<List<ClassModel>> getClasses(String institutionId);

  /// Create a new class
  Future<void> createClass(String institutionId, ClassModel newClass);

  /// Update an existing class
  Future<void> updateClass(String institutionId, ClassModel updatedClass);

  /// Delete a class
  Future<void> deleteClass(String institutionId, String classId);
}

/// Implementation of ClassRemoteDataSource using Firebase
class ClassRemoteDataSourceImpl implements ClassRemoteDataSource {
  final FirebaseFirestore _firestore;

  ClassRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<List<ClassModel>> getClasses(String institutionId) async {
    final snapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .get();
    return snapshot.docs.map((doc) => ClassModel.fromJson(doc.data())).toList();
  }

  @override
  Future<void> createClass(String institutionId, ClassModel newClass) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(newClass.id)
        .set(newClass.toJson());
  }

  @override
  Future<void> updateClass(String institutionId, ClassModel updatedClass) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(updatedClass.id)
        .update(updatedClass.toJson());
  }

  @override
  Future<void> deleteClass(String institutionId, String classId) {
    return _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('classes')
        .doc(classId)
        .delete();
  }
}
