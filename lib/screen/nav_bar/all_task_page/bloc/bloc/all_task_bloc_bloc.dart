import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_task_bloc_event.dart';
part 'all_task_bloc_state.dart';

class AllTaskBlocBloc extends Bloc<AllTaskBlocEvent, AllTaskBlocState> {
  AllTaskBlocBloc() : super(AllTaskBlocInitial()) {
    on<AllTaskBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
