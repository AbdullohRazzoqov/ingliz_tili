// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'test_bloc.dart';

@immutable
abstract class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDictionaryEvent extends TestEvent {
  Dicionary dicionary;
  AddDictionaryEvent({
    required this.dicionary,
  });

  @override
  List<Object?> get props => [dicionary];
}

class AllInstanseEvent extends TestEvent {}

class NewTestEvent extends TestEvent {
  String answer;
  NewTestEvent({
    required this.answer,
  });
}
