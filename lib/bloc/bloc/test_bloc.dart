import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ingliz_tili/stateStatus.dart';
import 'package:meta/meta.dart';

import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/db/objectbox.dart';
import 'package:ingliz_tili/objectbox.g.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  bool isInlish = true;
  bool startTest = false;
  List<Dicionary> dicionary = [];
  late ObjectBox objectBox;
  late Box<Dicionary> box;
  Dicionary currentTest = Dicionary(uz: '', ing: '');
  bool openBox = true;
  void noStart() {
    startTest = false;
    print("START: $startTest");
  }

  TestBloc() : super(TestInitial()) {
    if (openBox) {
      instanse();
      openBox = false;
    }
    on<DeleteDictionaryEvent>((event, emit) {
      dicionary.removeAt(event.id);
      box.removeAll();
      for (int i = 0; i < dicionary.length; i++) {
        box.put(Dicionary(uz: dicionary[i].uz, ing: dicionary[i].ing));
      }

      emit(DicionaryListState(dicionaryList: dicionary));
    });
    on<ControllerTilEvent>((event, emit) {
      isInlish = !isInlish;
      startTest = false;
      add(NewTestEvent(answer: ''));
    });
    on<AllDictionaryEvent>((event, emit) {
      emit(
        DicionaryListState(dicionaryList: dicionary),
      );
    });
    on<NewTestEvent>((event, emit) async {
      if (startTest) {
        if (validat(event.answer) ==
            (isInlish ? currentTest.uz : currentTest.ing)) {
          emit(DoneState());
          await Future.delayed(const Duration(seconds: 1));
          currentTest = randomTest(dicionary);
          emit(DictionaryState(
              dicionary: currentTest, stateStatus: StateStatus.loaded));
        } else {
          emit(DictionaryState(
              dicionary: currentTest,
              stateStatus: StateStatus.loaded,
              error: "Xato"));
        }
      } else {
        if (dicionary.isNotEmpty) {
          currentTest = randomTest(dicionary);
          emit(DictionaryState(dicionary: currentTest));
          startTest = true;
        } else {
          emit(ErrorState());
        }
      }
    });
    on<AddDictionaryEvent>((event, emit) {
      box.put(
        Dicionary(
          uz: validat(event.dicionary.uz),
          ing: validat(event.dicionary.ing),
        ),
      );
      updateList();
    });
  }
  String validat(String text) {
    text.toLowerCase();
    text.trim();
    return text;
  }

  void updateList() {
    dicionary.clear();
    dicionary = box.getAll();
  }

  Dicionary randomTest(List<Dicionary> dicionary) {
    Random random = Random();
    Dicionary dicionaryItem = dicionary[random.nextInt(dicionary.length)];
    return dicionaryItem;
  }

  void instanse() async {
    objectBox = await ObjectBox.create();
    box = objectBox.store.box<Dicionary>();
    dicionary = box.getAll();
  }
}
