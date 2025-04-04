import 'package:equatable/equatable.dart';

enum VisitType { loan, dc, goldStorage, release }
enum VisitStatus { notStarted, inProgress, completed }

class Visit extends Equatable {
  final String id;
  final String customerName;
  final DateTime dateTime;
  final VisitType type;
  final VisitStatus status;

  const Visit({
    required this.id,
    required this.customerName,
    required this.dateTime,
    required this.type,
    required this.status,
  });

  @override
  List<Object?> get props => [id, customerName, dateTime, type, status];
} 