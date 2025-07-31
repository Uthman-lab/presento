part of 'report_generation_bloc.dart';

@freezed
class ReportGenerationEvent with _$ReportGenerationEvent {
  const factory ReportGenerationEvent.generateReport({
    required String institutionId,
    required String classId,
    required DateTime startDate,
    required DateTime endDate,
    required String format,
  }) = ReportGenerationGenerateReport;
}
