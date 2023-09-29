import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/screen/nav_bar/home_page/bloc/test_bloc.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigoAccent,
        actions: [
          GestureDetector(
            onTap: () {
              addDictionaryDialog();
            },
            child: const Icon(
              Icons.add,
              size: 32,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      backgroundColor: AppColors.color,
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.indigoAccent),
            child: Center(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<HomePageBloc>().isInlish
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
                                .read<HomePageBloc>()
                                .add(ControllerTilEvent());
                          },
                          child: SvgPicture.asset(
                            'assets/svg/transform.svg',
                            height: 20,
                            width: 20,
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        context.read<HomePageBloc>().isInlish
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
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (BuildContext context, HomePageState state) {
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
                      context.read<HomePageBloc>().isInlish
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
                return const Center(
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
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
          BlocBuilder<HomePageBloc, HomePageState>(
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
                      !context.read<HomePageBloc>().startTest) {
                    context.read<HomePageBloc>().add(
                        NewHomePageEvent(answer: _textEditingController.text));
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
                    child: BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        return Text(
                          context.read<HomePageBloc>().startTest
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
                      context.read<HomePageBloc>().add(
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
