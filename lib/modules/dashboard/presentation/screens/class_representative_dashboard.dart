import 'package:presento/imports.dart';
import 'package:presento/modules/auth/presentation/presentation.dart';

class ClassRepresentativeDashboard extends StatelessWidget {
  const ClassRepresentativeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Representative Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutRequested());
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              'Class Representative Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Assist with attendance for your assigned class',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              'Available Actions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text('• Mark Attendance for Assigned Class'),
            Text('• View Class Attendance'),
            Text('• View Class Roster'),
            Text('• Generate Class Reports'),
          ],
        ),
      ),
    );
  }
}


