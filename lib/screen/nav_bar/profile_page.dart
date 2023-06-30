import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingliz_tili/bloc/bloc/test_bloc.dart';
import 'package:ingliz_tili/utils/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<TestBloc>().add(AllDictionaryEvent());
    context.read<TestBloc>().noStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color,
      body: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          if (state is DicionaryListState) {
            return state.dicionaryList.isNotEmpty
                ? ListView.builder(
                    itemCount: state.dicionaryList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        height: MediaQuery.of(context).size.width * 0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white),
                        child: ListTile(
                          title: Text(
                            state.dicionaryList[index].uz,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            state.dicionaryList[index].ing,
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                context
                                    .read<TestBloc>()
                                    .add(DeleteDictionaryEvent(id: index));
                              },
                              child: const Icon(Icons.delete)),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                    "Hali Lug'at qo'shilmagan",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo),
                  ));
          } else {
            return const Center(
              child: Text("Hali Lug'at qo'shilmagan"),
            );
          }
        },
      ),
    );
  }
}
