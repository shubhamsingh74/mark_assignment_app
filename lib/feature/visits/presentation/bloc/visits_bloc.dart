import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';

// Events
abstract class VisitsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadVisits extends VisitsEvent {}

class FilterVisits extends VisitsEvent {
  final VisitType? type;
  final VisitStatus? status;

  FilterVisits({this.type, this.status});

  @override
  List<Object?> get props => [type, status];
}

class SearchVisits extends VisitsEvent {
  final String query;

  SearchVisits(this.query);

  @override
  List<Object?> get props => [query];
}

// States
abstract class VisitsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitsInitial extends VisitsState {}

class VisitsLoading extends VisitsState {}

class VisitsLoaded extends VisitsState {
  final List<Visit> visits;

  VisitsLoaded(this.visits);

  @override
  List<Object?> get props => [visits];
}

class VisitsError extends VisitsState {
  final String message;

  VisitsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class VisitsBloc extends Bloc<VisitsEvent, VisitsState> {
  final VisitRepository repository;

  VisitsBloc({required this.repository}) : super(VisitsInitial()) {
    on<LoadVisits>(_onLoadVisits);
    on<FilterVisits>(_onFilterVisits);
    on<SearchVisits>(_onSearchVisits);
  }

  Future<void> _onLoadVisits(LoadVisits event, Emitter<VisitsState> emit) async {
    emit(VisitsLoading());
    final result = await repository.getVisits();
    result.fold(
      (failure) => emit(VisitsError('Failed to load visits')),
      (visits) => emit(VisitsLoaded(visits)),
    );
  }

  Future<void> _onFilterVisits(FilterVisits event, Emitter<VisitsState> emit) async {
    emit(VisitsLoading());
    final result = await repository.filterVisits(
      type: event.type,
      status: event.status,
    );
    result.fold(
      (failure) => emit(VisitsError('Failed to filter visits')),
      (visits) => emit(VisitsLoaded(visits)),
    );
  }

  Future<void> _onSearchVisits(SearchVisits event, Emitter<VisitsState> emit) async {
    emit(VisitsLoading());
    final result = await repository.searchVisits(event.query);
    result.fold(
      (failure) => emit(VisitsError('Failed to search visits')),
      (visits) => emit(VisitsLoaded(visits)),
    );
  }
} 