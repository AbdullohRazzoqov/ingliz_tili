import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingliz_tili/bloc/bloc/test_bloc.dart';
import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/utils/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textEditingController =
      TextEditingController();
  late final TextEditingController _textEditingAddEnglish =
      TextEditingController();
  late final TextEditingController _textEditingAddUzbek =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.color,
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.indigoAccent),
              child: Center(
                child: BlocBuilder<TestBloc, TestState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.read<TestBloc>().isInlish
                              ? "Inliz tili"
                              : "Uzbek tili",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                            onTap: () {
                              context
                                  .read<TestBloc>()
                                  .add(ControllerTilEvent());
                            },
                            child: const Icon(Icons.toc_rounded)),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          context.read<TestBloc>().isInlish
                              ? "Uzbek tili"
                              : "Ingliz tili",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            BlocBuilder<TestBloc, TestState>(
              builder: (BuildContext context, TestState state) {
                if (state is DictionaryState) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        context.read<TestBloc>().isInlish
                            ? state.dicionary.ing
                            : state.dicionary.uz,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                } else if (state is ErrorState) {
                  return const Text(
                    "Sizda Lug'at mavjud emas",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigoAccent),
                  );
                } else if (state is DoneState) {
                  return Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 80,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<TestBloc, TestState>(
              builder: (context, state) {
                if (state is DictionaryState && state.error.isNotEmpty) {
                  return const Text(
                    "Siz bergan javob no to'g'ri",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w600),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_textEditingController.text.isNotEmpty ||
                        !context.read<TestBloc>().startTest) {
                      context.read<TestBloc>().add(
                          NewTestEvent(answer: _textEditingController.text));
                      _textEditingController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.cyan,
                          content: Text("Iltomos savolni javobini yozing"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.indigoAccent),
                    child: Center(
                      child: BlocBuilder<TestBloc, TestState>(
                        builder: (context, state) {
                          return Text(
                            context.read<TestBloc>().startTest
                                ? "Keyingisi"
                                : "Boshlash",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addDictionaryDialog();
          },
          backgroundColor: Colors.indigoAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> addDictionaryDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            title: SizedBox(
              width: 400,
              height: 170,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingAddEnglish,
                    decoration: InputDecoration(
                      hintText: 'English',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _textEditingAddUzbek,
                    decoration: InputDecoration(
                      hintText: 'Uzbek',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_textEditingAddEnglish.text.isNotEmpty &&
                        _textEditingAddUzbek.text.isNotEmpty) {
                      context.read<TestBloc>().add(
                            AddDictionaryEvent(
                              dicionary: Dicionary(
                                uz: _textEditingAddUzbek.text,
                                ing: _textEditingAddEnglish.text,
                              ),
                            ),
                          );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text("Qo'shish"))
            ],
          );
        });
  }
}
