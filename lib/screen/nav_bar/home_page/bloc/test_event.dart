// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'test_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDictionaryEvent extends HomePageEvent {
  final Dicionary dicionary;
  AddDictionaryEvent({
    required this.dicionary,
  });

  @override
  List<Object?> get props => [dicionary];
}

class AllInstanseEvent extends HomePageEvent {}

class NewHomePageEvent extends HomePageEvent {
  final String answer;
  NewHomePageEvent({
    required this.answer,
  });
}

class AllDictionaryEvent extends HomePageEvent {}

class DeleteDictionaryEvent extends HomePageEvent {
  final int id;
  DeleteDictionaryEvent({
    required this.id,
  });
}

class ControllerTilEvent extends HomePageEvent {}
