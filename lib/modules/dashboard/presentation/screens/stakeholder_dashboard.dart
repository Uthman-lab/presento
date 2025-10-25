import 'package:presento/imports.dart';
import 'package:presento/modules/auth/presentation/presentation.dart';

class StakeholderDashboard extends StatelessWidget {
  const StakeholderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stakeholder Dashboard'),
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
            Icon(Icons.family_restroom, size: 64, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'Stakeholder Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'View authorized student attendance records',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              'Available Actions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text('• View Student Attendance'),
            Text('• View Attendance Reports'),
            Text('• Receive Notifications'),
            Text('• Contact Institution'),
          ],
        ),
      ),
    );
  }
}


