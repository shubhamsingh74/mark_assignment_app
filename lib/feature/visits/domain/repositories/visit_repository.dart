import 'package:dartz/dartz.dart';
import '../entities/visit.dart';
import '../../../../core/error/failures.dart';

abstract class VisitRepository {
  Future<Either<Failure, List<Visit>>> getVisits();
  Future<Either<Failure, List<Visit>>> searchVisits(String query);
  Future<Either<Failure, List<Visit>>> filterVisits({
    VisitType? type,
    VisitStatus? status,
  });
  Future<Either<Failure, Visit>> getVisitById(String id);
} 