import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../../../core/error/failures.dart';

part 'report_generation_bloc.freezed.dart';
part 'report_generation_event.dart';
part 'report_generation_state.dart';

class ReportGenerationBloc
    extends Bloc<ReportGenerationEvent, ReportGenerationState> {
  final FirebaseFunctions _functions;

  ReportGenerationBloc({required FirebaseFunctions functions})
    : _functions = functions,
      super(const ReportGenerationState.initial()) {
    on<ReportGenerationGenerateReport>(_onGenerateReport);
  }

  Future<void> _onGenerateReport(
    ReportGenerationGenerateReport event,
    Emitter<ReportGenerationState> emit,
  ) async {
    emit(const ReportGenerationState.generating());

    try {
      final callable = _functions.httpsCallable('generateAttendanceReport');

      final result = await callable.call({
        'institutionId': event.institutionId,
        'classId': event.classId,
        'startDate': event.startDate.toIso8601String(),
        'endDate': event.endDate.toIso8601String(),
        'format': event.format,
      });

      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        emit(
          ReportGenerationState.reportGenerated(
            data: data['data'] as String,
            fileName: data['fileName'] as String,
          ),
        );
      } else {
        emit(
          ReportGenerationState.error(
            ServerFailure(data['error'] ?? 'Failed to generate report'),
          ),
        );
      }
    } catch (e) {
      emit(ReportGenerationState.error(ServerFailure(e.toString())));
    }
  }
}
