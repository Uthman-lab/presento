import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:task_master_tot/features/dashboard/presentation/widgets/attendance_bar_chart.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';

import '../../../attendance/domain/usecases/get_attendance_by_date_range.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAttendanceByDateRange _getAttendanceByDateRange;
  final FirebaseFunctions _functions;

  DashboardBloc({
    required GetAttendanceByDateRange getAttendanceByDateRange,
    required FirebaseFunctions functions,
  }) : _getAttendanceByDateRange = getAttendanceByDateRange,
       _functions = functions,
       super(const DashboardState.initial()) {
    on<DashboardLoadDashboard>(_onLoadDashboard);
    on<DashboardRefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    DashboardLoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());

    try {
      // Get analytics data from Firebase Function
      final callable = _functions.httpsCallable('getAttendanceAnalytics');

      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 7));

      final result = await callable.call({
        'institutionId': event.user.institutionId,
        'classId': 'all', // Get data for all classes
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'aggregationType': 'daily',
      });

      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        final analyticsData = data['data'] as List<dynamic>;

        // Transform analytics data for charts
        final chartData = _transformAnalyticsData(analyticsData);

        // Calculate summary statistics
        final summaryStats = _calculateSummaryStats(analyticsData);

        final dashboardData = DashboardData(
          totalRecords: summaryStats['totalRecords'],
          presentCount: summaryStats['presentCount'],
          absentCount: summaryStats['absentCount'],
          lateCount: summaryStats['lateCount'],
          excusedCount: summaryStats['excusedCount'],
          presentPercentage: summaryStats['presentPercentage'],
          absentPercentage: summaryStats['absentPercentage'],
          latePercentage: summaryStats['latePercentage'],
          excusedPercentage: summaryStats['excusedPercentage'],
          chartData: chartData,
          quickActions: _getQuickActions(event.user.role),
        );

        emit(
          DashboardState.dashboardLoaded(
            dashboardData: dashboardData,
            user: event.user,
          ),
        );
      } else {
        emit(
          DashboardState.error(
            ServerFailure(data['error'] ?? 'Failed to load dashboard data'),
          ),
        );
      }
    } catch (e) {
      emit(DashboardState.error(ServerFailure(e.toString())));
    }
  }

  Future<void> _onRefreshDashboard(
    DashboardRefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    // Re-load dashboard data
    final currentState = state;
    if (currentState is _DashboardLoaded) {
      add(DashboardEvent.loadDashboard(currentState.user));
    }
  }

  List<AttendanceDataPoint> _transformAnalyticsData(
    List<dynamic> analyticsData,
  ) {
    return analyticsData.map((data) {
      return AttendanceDataPoint(
        date: data['date'] as String,
        shortDate: data['shortDate'] as String,
        presentCount: data['presentCount'] as int,
        absentCount: data['absentCount'] as int,
        lateCount: data['lateCount'] as int,
        excusedCount: data['excusedCount'] as int,
      );
    }).toList();
  }

  Map<String, dynamic> _calculateSummaryStats(List<dynamic> analyticsData) {
    int totalRecords = 0;
    int presentCount = 0;
    int absentCount = 0;
    int lateCount = 0;
    int excusedCount = 0;

    for (final data in analyticsData) {
      totalRecords += data['totalCount'] as int;
      presentCount += data['presentCount'] as int;
      absentCount += data['absentCount'] as int;
      lateCount += data['lateCount'] as int;
      excusedCount += data['excusedCount'] as int;
    }

    return {
      'totalRecords': totalRecords,
      'presentCount': presentCount,
      'absentCount': absentCount,
      'lateCount': lateCount,
      'excusedCount': excusedCount,
      'presentPercentage': totalRecords > 0
          ? (presentCount / totalRecords) * 100
          : 0,
      'absentPercentage': totalRecords > 0
          ? (absentCount / totalRecords) * 100
          : 0,
      'latePercentage': totalRecords > 0 ? (lateCount / totalRecords) * 100 : 0,
      'excusedPercentage': totalRecords > 0
          ? (excusedCount / totalRecords) * 100
          : 0,
    };
  }

  List<QuickAction> _getQuickActions(String userRole) {
    final actions = <QuickAction>[];

    switch (userRole) {
      case 'admin':
        actions.addAll([
          QuickAction(
            title: 'Manage Classes',
            icon: 'class',
            route: '/class-management',
            color: Colors.blue,
          ),
          QuickAction(
            title: 'Manage Students',
            icon: 'people',
            route: '/student-management',
            color: Colors.green,
          ),
          QuickAction(
            title: 'Generate Reports',
            icon: 'assessment',
            route: '/report-generation',
            color: Colors.orange,
          ),
        ]);
        break;
      case 'supervisor':
        actions.addAll([
          QuickAction(
            title: 'View All Classes',
            icon: 'visibility',
            route: '/view-attendance',
            color: Colors.purple,
          ),
          QuickAction(
            title: 'Generate Reports',
            icon: 'assessment',
            route: '/report-generation',
            color: Colors.orange,
          ),
        ]);
        break;
      case 'class_rep':
        actions.addAll([
          QuickAction(
            title: 'Take Attendance',
            icon: 'checklist',
            route: '/attendance-taking',
            color: Colors.green,
          ),
          QuickAction(
            title: 'View My Class',
            icon: 'visibility',
            route: '/view-attendance',
            color: Colors.purple,
          ),
        ]);
        break;
      case 'stakeholder':
        actions.addAll([
          QuickAction(
            title: 'View Attendance',
            icon: 'visibility',
            route: '/view-attendance',
            color: Colors.purple,
          ),
          QuickAction(
            title: 'View Reports',
            icon: 'assessment',
            route: '/attendance-report',
            color: Colors.orange,
          ),
        ]);
        break;
    }

    return actions;
  }
}

class DashboardData {
  final int totalRecords;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final double presentPercentage;
  final double absentPercentage;
  final double latePercentage;
  final double excusedPercentage;
  final List<AttendanceDataPoint> chartData;
  final List<QuickAction> quickActions;

  DashboardData({
    required this.totalRecords,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    required this.presentPercentage,
    required this.absentPercentage,
    required this.latePercentage,
    required this.excusedPercentage,
    required this.chartData,
    required this.quickActions,
  });
}

class QuickAction {
  final String title;
  final String icon;
  final String route;
  final Color color;

  QuickAction({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}
