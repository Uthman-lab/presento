part of 'report_generation_bloc.dart';

@freezed
class ReportGenerationState with _$ReportGenerationState {
  const factory ReportGenerationState.initial() = _Initial;
  const factory ReportGenerationState.generating() = _Generating;
  const factory ReportGenerationState.reportGenerated({
    required String data,
    required String fileName,
  }) = _ReportGenerated;
  const factory ReportGenerationState.error(Failure failure) = _Error;
}
