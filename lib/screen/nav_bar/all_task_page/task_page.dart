import 'package:flutter/material.dart';
import 'package:ingliz_tili/screen/nav_bar/all_task_page/savol/savol.dart';
import 'package:ingliz_tili/utils/color.dart';

List<Widget> page = [Savollar()];

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool replaseItem = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.color,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      "Bizning bo'limlar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          replaseItem = true;
                        });
                      },
                      child: const Icon(Icons.view_agenda),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          replaseItem = false;
                        });
                      },
                      child: const Icon(Icons.grid_view_rounded),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: replaseItem ? ItemList() : ItemGrid(),
              ),
            ],
          ),
        ));
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: page.length,
        itemBuilder: (context, index) {
          if (index == 0) {}
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => page[index]));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(left: 12, top: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.book,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Ingliz tili bo'yicha darsliklar",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ItemGrid extends StatelessWidget {
  const ItemGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: page.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page[index]));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  Icons.book,
                  color: Colors.red,
                ),
                Text(
                  "Ingliz tili bo'yicha darsliklar",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
    );
  }
}
