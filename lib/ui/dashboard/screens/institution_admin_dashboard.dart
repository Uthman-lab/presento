import 'package:presento/imports.dart';
import 'package:presento/ui/auth/auth.ui.dart';

class InstitutionAdminDashboard extends StatelessWidget {
  const InstitutionAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Institution Admin Dashboard'),
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
            Icon(Icons.school, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Institution Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Institution management and oversight',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              'Available Actions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text('• Manage Institution Users'),
            Text('• Create and Manage Classes'),
            Text('• Student Management'),
            Text('• Attendance Reports'),
            Text('• Institution Analytics'),
          ],
        ),
      ),
    );
  }
}


