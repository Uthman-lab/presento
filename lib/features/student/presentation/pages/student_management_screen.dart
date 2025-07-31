import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/student_management_bloc.dart';
import '../../domain/entities/student.dart';

class StudentManagementScreen extends StatefulWidget {
  final String institutionId;
  final String classId;
  const StudentManagementScreen({
    super.key,
    required this.institutionId,
    required this.classId,
  });

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentManagementBloc>().add(
          StudentManagementEvent.loadStudents(
            widget.institutionId,
            widget.classId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add student screen
            },
          ),
        ],
      ),
      body: BlocConsumer<StudentManagementBloc, StudentManagementState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(failure.message)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (students) {
              if (students.isEmpty) {
                return const Center(
                  child: Text('No students found. Add your first student!'),
                );
              }
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(student.name[0].toUpperCase()),
                      ),
                      title: Text(student.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${student.studentId}'),
                          if (student.email != null) Text('Email: ${student.email}'),
                          if (student.age != null) Text('Age: ${student.age}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // TODO: Navigate to edit student screen
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteDialog(student);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navigate to student details screen
                      },
                    ),
                  );
                },
              );
            },
            orElse: () => const Center(child: Text('Loading students...')),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete "${student.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<StudentManagementBloc>().add(
                    StudentManagementEvent.deleteStudent(
                      widget.institutionId,
                      student.id,
                      widget.classId,
                    ),
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 