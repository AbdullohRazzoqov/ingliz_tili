// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'test_bloc.dart';

@immutable
abstract class HomePageState {}

class TestInitial extends HomePageState {}

class DictionaryState extends HomePageState {
  final StateStatus stateStatus;
  final String error;
  final Dicionary dicionary;
  DictionaryState(
      {required this.dicionary,
      this.stateStatus = StateStatus.normal,
      this.error = ''});
}

class DicionaryListState extends HomePageState {
  final List<Dicionary> dicionaryList;
  DicionaryListState({
    required this.dicionaryList,
  });
}

class ErrorState extends HomePageState {}

class DoneState extends HomePageState {}
