part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.loadDashboard(User user) =
      DashboardLoadDashboard;
  const factory DashboardEvent.refreshDashboard() = DashboardRefreshDashboard;
}
