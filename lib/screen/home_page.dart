import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingliz_tili/bloc/bloc/test_bloc.dart';
import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/utils/color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingAddEnglish = TextEditingController();
  final TextEditingController _textEditingAddUzbek = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.color,
        appBar: AppBar(
          backgroundColor: AppColors.color,
          title: const Text("Ingliz test"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                     return   AlertDialog(
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
                                  context.read<TestBloc>().add(
                                        AddDictionaryEvent(
                                          dicionary: Dicionary(
                                              uz: "sher", ing: 'lion'),
                                        ),
                                      );
                                  Navigator.pop(context);
                                },
                                child: const Text("Qo'shish"))
                          ],
                        );
                      });
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
              builder: (context, state) {
                if (state is AllDictionaryState) {
                  return Text(state.dicionary!.ing);
                } else {
                  return SizedBox();
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_textEditingController.text.isNotEmpty) {
              context
                  .read<TestBloc>()
                  .add(NewTestEvent(answer: _textEditingController.text));
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
}
