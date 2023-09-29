import 'package:flutter/material.dart';
import 'package:ingliz_tili/utils/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Savollar'),
        ),
        body: Savollar(),
      ),
    );
  }
}

class Savollar extends StatefulWidget {
  @override
  State<Savollar> createState() => _SavollarState();
}

class _SavollarState extends State<Savollar> {
  final String a = 'Hello Abdulloh';
  final String b = 'Salom Abdulloh';

  final List<String> savol = 'Hello Abdulloh'.split(' ');

  List javob = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 40),
          Wrap(
            children: javob.map((e) {
              return GestureDetector(
                onTap: () {
                  javob.remove(e);
                  savol.add(e);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.color),
                    child: Text(
                      e,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            children: savol.map((e) {
              print(e);
              return GestureDetector(
                onTap: () {
                  savol.remove(e);
                  javob.add(e);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.color),
                      child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.amber,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue),
                child: Text(
                  'SKIP',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue),
                child: Text(
                  'Check',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
}
