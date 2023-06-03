// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class AllDictionaryState extends TestState {
  List<Dicionary> dicionaryList;
  Dicionary? dicionary;
  AllDictionaryState({
    this.dicionaryList = const [],
    this.dicionary,
  });
}
