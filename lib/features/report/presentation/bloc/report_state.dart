part of 'report_bloc.dart';

class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class UserReporting extends ReportState {}

class UserReported extends ReportState {}

class UserReportError extends ReportState {}
