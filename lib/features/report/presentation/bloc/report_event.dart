part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportUser extends ReportEvent {
  final String description;
  final int category;
  final int recipient;
  const ReportUser({
    required this.category,
    required this.description,
    required this.recipient,
  });
}
