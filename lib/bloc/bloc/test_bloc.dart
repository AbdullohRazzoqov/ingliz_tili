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
      print('object');
      print("${event.answer}  ${currentTest.uz}");
      if (event.answer == currentTest.uz) {
        currentTest = randomTest(dicionary);
        print("${currentTest.uz} ${randomTest(dicionary).uz}");
        emit(AllDictionaryState(dicionary: currentTest));
      }
    });
    on<AddDictionaryEvent>((event, emit) {
      box.put(Dicionary(uz: event.dicionary.uz, ing: event.dicionary.ing));
      print(box.getAll().length);
      updateList();
      print(box.getAll().length);

    });
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
    if (dicionary.isNotEmpty) {
      add(NewTestEvent(answer: ''));
    }
  }
}
