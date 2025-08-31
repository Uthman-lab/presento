import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/attendance_bar_chart.dart';
import '../widgets/attendance_pie_chart.dart';
import '../../../core/ui/models.dart';
import '../../../modules/auth/domain/entities/user.dart';

class RoleBasedDashboardScreen extends StatefulWidget {
  final User user;
  const RoleBasedDashboardScreen({super.key, required this.user});

  @override
  State<RoleBasedDashboardScreen> createState() =>
      _RoleBasedDashboardScreenState();
}

class _RoleBasedDashboardScreenState extends State<RoleBasedDashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  void _loadDashboard() {
    context.read<DashboardBloc>().add(
      DashboardEvent.loadDashboard(widget.user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.user.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboard,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
              context.go('/login');
            },
          ),
        ],
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${failure.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            dashboardLoaded: (dashboardData, user) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(user),
                    const SizedBox(height: 24),
                    _buildStatisticsSection(dashboardData),
                    const SizedBox(height: 24),
                    _buildChartsSection(dashboardData),
                    const SizedBox(height: 24),
                    _buildRoleSpecificSection(dashboardData, user),
                    const SizedBox(height: 24),
                    _buildQuickActionsSection(dashboardData),
                  ],
                ),
              );
            },
            orElse: () => const Center(child: Text('Loading dashboard...')),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: _getRoleColor(user.role),
                  child: Icon(
                    _getRoleIcon(user.role),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${user.name}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Role: ${_getRoleDisplayName(user.role)}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      Text(
                        'Institution: ${user.institutionId}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Attendance Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Records',
                    dashboardData.totalRecords.toString(),
                    Icons.list,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Present',
                    '${dashboardData.presentCount} (${dashboardData.presentPercentage.toStringAsFixed(1)}%)',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Absent',
                    '${dashboardData.absentCount} (${dashboardData.absentPercentage.toStringAsFixed(1)}%)',
                    Icons.cancel,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Late',
                    '${dashboardData.lateCount} (${dashboardData.latePercentage.toStringAsFixed(1)}%)',
                    Icons.schedule,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance Analytics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (dashboardData.chartData.isNotEmpty) ...[
              SizedBox(
                height: 300,
                child: AttendanceBarChart(dataPoints: dashboardData.chartData),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: AttendancePieChart(
                  presentCount: dashboardData.presentCount,
                  absentCount: dashboardData.absentCount,
                  lateCount: dashboardData.lateCount,
                  excusedCount: dashboardData.excusedCount,
                ),
              ),
            ] else ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'No attendance data available for the selected period',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSpecificSection(DashboardData dashboardData, User user) {
    switch (user.role) {
      case 'admin':
        return _buildAdminSection(dashboardData);
      case 'supervisor':
        return _buildSupervisorSection(dashboardData);
      case 'class_rep':
        return _buildClassRepSection(dashboardData);
      case 'stakeholder':
        return _buildStakeholderSection(dashboardData);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAdminSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Administrative Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'Manage Classes',
                    Icons.class_,
                    Colors.blue,
                    () => context.push('/class-management'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    'Manage Students',
                    Icons.people,
                    Colors.green,
                    () => context.push('/student-management'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupervisorSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Supervisor Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'View All Classes',
                    Icons.visibility,
                    Colors.purple,
                    () => context.push('/view-attendance'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    'Generate Reports',
                    Icons.assessment,
                    Colors.orange,
                    () => context.push('/attendance-report'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassRepSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Class Representative Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'Take Attendance',
                    Icons.checklist,
                    Colors.green,
                    () => context.push('/attendance-taking'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    'View My Class',
                    Icons.visibility,
                    Colors.purple,
                    () => context.push('/view-attendance'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStakeholderSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stakeholder Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'View Attendance',
                    Icons.visibility,
                    Colors.purple,
                    () => context.push('/view-attendance'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    'View Reports',
                    Icons.assessment,
                    Colors.orange,
                    () => context.push('/attendance-report'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(DashboardData dashboardData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: dashboardData.quickActions.map((action) {
                return _buildQuickActionCard(action);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(QuickAction action) {
    return InkWell(
      onTap: () => context.push(action.route),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: action.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: action.color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              _getIconFromString(action.icon),
              color: action.color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              action.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: action.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return Colors.red;
      case 'supervisor':
        return Colors.blue;
      case 'class_rep':
        return Colors.green;
      case 'stakeholder':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'admin':
        return Icons.admin_panel_settings;
      case 'supervisor':
        return Icons.supervisor_account;
      case 'class_rep':
        return Icons.person;
      case 'stakeholder':
        return Icons.business;
      default:
        return Icons.person;
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case 'admin':
        return 'Administrator';
      case 'supervisor':
        return 'Supervisor';
      case 'class_rep':
        return 'Class Representative';
      case 'stakeholder':
        return 'Stakeholder';
      default:
        return 'User';
    }
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'class':
        return Icons.class_;
      case 'people':
        return Icons.people;
      case 'assessment':
        return Icons.assessment;
      case 'checklist':
        return Icons.checklist;
      case 'visibility':
        return Icons.visibility;
      default:
        return Icons.help;
    }
  }
}
