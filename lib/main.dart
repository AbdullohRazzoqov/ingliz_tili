import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingliz_tili/screen/nav_bar/home.dart';
import 'package:ingliz_tili/screen/nav_bar/home_page/bloc/test_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late HomePageBloc homePageBloc;
  @override
  void initState() {
    homePageBloc = HomePageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ingliz tili',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => homePageBloc,
        child: const Home(),
      ),
    );
  }
}

class NeumorphismPage extends StatefulWidget {
  const NeumorphismPage({Key? key}) : super(key: key);

  @override
  State<NeumorphismPage> createState() => _NeumorphismPageState();
}

class _NeumorphismPageState extends State<NeumorphismPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
                width: 60, height: 60, decoration: UiDecoration.myDecoration()),
          ),
        ],
      ),
    );
  }
}

class UiDecoration {
  static Decoration myDecoration() {
    return BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ]);
  }
}

  
  


// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

// void main() {
//   runApp(const ExampleApp());
// }

// const primaryColor = Color(0xFFE0E0E0);

// class ExampleApp extends StatelessWidget {
//   const ExampleApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Example',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: primaryColor,
//         body: Center(
//           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xFFEEEEED)),
//             width: 200,
//             height: 200,
//             padding: EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 Container(
//                   child: Center(
//                     child: Text(
//                       "10 : 20",
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   width: 150,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     color: Color(0xFFEDEDED),
//                     boxShadow: const [
//                       BoxShadow(
//                         offset: Offset(-10, -10),
//                         blurRadius: 5,
//                         color: Colors.white,spreadRadius: -4,
//                         inset: true,
//                       ),
//                       BoxShadow(
//                         offset: Offset(10, 10),
//                         blurRadius: 5,spreadRadius: -4,
//                         color: Color(0xFFBEBEBE),
//                         inset: true,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text('20/10/20 Mon'),
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
