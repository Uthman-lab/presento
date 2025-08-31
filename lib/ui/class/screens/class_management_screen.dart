import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/class_management_bloc.dart';
import '../../../modules/class/domain/entities/class.dart';

class ClassManagementScreen extends StatefulWidget {
  final String institutionId;
  const ClassManagementScreen({super.key, required this.institutionId});

  @override
  State<ClassManagementScreen> createState() => _ClassManagementScreenState();
}

class _ClassManagementScreenState extends State<ClassManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ClassManagementBloc>().add(
      ClassManagementEvent.loadClasses(widget.institutionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add class screen
            },
          ),
        ],
      ),
      body: BlocConsumer<ClassManagementBloc, ClassManagementState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (classes) {
              if (classes.isEmpty) {
                return const Center(
                  child: Text('No classes found. Add your first class!'),
                );
              }
              return ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final classItem = classes[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(classItem.name),
                      subtitle: Text(classItem.description ?? 'No description'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // TODO: Navigate to edit class screen
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteDialog(classItem);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navigate to class details screen
                      },
                    ),
                  );
                },
              );
            },
            orElse: () => const Center(child: Text('Loading classes...')),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(Class classItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Class'),
        content: Text('Are you sure you want to delete "${classItem.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ClassManagementBloc>().add(
                ClassManagementEvent.deleteClass(
                  widget.institutionId,
                  classItem.id,
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
