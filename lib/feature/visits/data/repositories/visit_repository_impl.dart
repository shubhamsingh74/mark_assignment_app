import 'package:dartz/dartz.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../../../../core/error/failures.dart';

class VisitRepositoryImpl implements VisitRepository {
  // Mock data for demonstration
  final List<Visit> _mockVisits = [
    Visit(
      id: 'TCV00010010',
      customerName: 'Shantham krishnan',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.loan,
      status: VisitStatus.inProgress,
    ),
    Visit(
      id: 'OMDCV00023',
      customerName: 'Shantham krishnan',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.dc,
      status: VisitStatus.notStarted,
    ),
    Visit(
      id: 'TCV00010011',
      customerName: 'Murugan Pushparaj',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.goldStorage,
      status: VisitStatus.notStarted,
    ),
    Visit(
      id: 'TCV00010011',
      customerName: 'Murugan Pushparaj',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.goldStorage,
      status: VisitStatus.notStarted,
    ),
    Visit(
      id: 'TCV00010011',
      customerName: 'Murugan Pushparaj',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.goldStorage,
      status: VisitStatus.notStarted,
    ),
    Visit(
      id: 'TCV00010011',
      customerName: 'Murugan Pushparaj',
      dateTime: DateTime(2025, 1, 12, 15, 0),
      type: VisitType.goldStorage,
      status: VisitStatus.notStarted,
    ),
  ];

  @override
  Future<Either<Failure, List<Visit>>> getVisits() async {
    try {
      return Right(_mockVisits);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Visit>>> searchVisits(String query) async {
    try {
      final results = _mockVisits.where((visit) {
        return visit.id.toLowerCase().contains(query.toLowerCase()) ||
            visit.customerName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      return Right(results);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Visit>>> filterVisits({
    VisitType? type,
    VisitStatus? status,
  }) async {
    try {
      var filteredVisits = _mockVisits;

      if (type != null) {
        filteredVisits = filteredVisits.where((visit) => visit.type == type).toList();
      }

      if (status != null) {
        filteredVisits = filteredVisits.where((visit) => visit.status == status).toList();
      }

      return Right(filteredVisits);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Visit>> getVisitById(String id) async {
    try {
      final visit = _mockVisits.firstWhere(
        (visit) => visit.id == id,
        orElse: () => throw Exception('Visit not found'),
      );
      return Right(visit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
} 