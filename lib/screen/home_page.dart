import 'dart:math';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingliz_tili/bloc/bloc/test_bloc.dart';
import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/utils/color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: const Text("Ingliz test"),
          actions: [
            IconButton(
                onPressed: () {
                  addDictionaryDialog();
                },
                icon: const Icon(Icons.add))
          ],
          elevation: 0.0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            BlocBuilder<TestBloc, TestState>(
              builder: (BuildContext context, TestState state) {
                if (state is AllDictionaryState) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(2),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFF7F2FA)),
                    child: Text(
                      state.dicionary!.ing,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF003366),
                          fontWeight: FontWeight.w600),
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
         
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_textEditingController.text.isNotEmpty ||
                !context.read<TestBloc>().startTest) {
              context
                  .read<TestBloc>()
                  .add(NewTestEvent(answer: _textEditingController.text));
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
          child: const Text("Next"),
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
