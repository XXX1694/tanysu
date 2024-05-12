import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/report/data/repositories/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportRepository repo;
  ReportBloc({
    required this.repo,
    required ReportState reportState,
  }) : super(ReportInitial()) {
    on<ReportUser>(
      (event, emit) async {
        emit(UserReporting());
        try {
          final res = await repo.reportProfile(
            description: event.description,
            category: event.category,
            recipient: event.recipient,
          );
          if (res == 201) {
            emit(UserReported());
          } else {
            emit(UserReportError());
          }
        } catch (e) {
          emit(UserReportError());
        }
      },
    );
  }
}
