import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/db/objectbox.dart';
import 'package:ingliz_tili/objectbox.g.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  bool startTest = false;
  List<Dicionary> dicionary = [];
  late ObjectBox objectBox;
  late Box<Dicionary> box;
  Dicionary currentTest = Dicionary(uz: '', ing: '');
  bool openBox = true;
  TestBloc() : super(TestInitial()) {
    if (openBox) {
      instanse();
      openBox = false;
    }
    on<NewTestEvent>((event, emit) {
      if (startTest) {
        if (validat(event.answer) == currentTest.uz) {
          currentTest = randomTest(dicionary);
          emit(AllDictionaryState(dicionary: currentTest));
        } else {}
      } else {
        currentTest = randomTest(dicionary);
        emit(AllDictionaryState(dicionary: currentTest));
        startTest = true;
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
