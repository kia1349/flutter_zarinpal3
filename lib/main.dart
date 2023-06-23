import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main_app.dart';

void main() async {
  await _initHive();
  runApp(const MainApp());
}

Future<void> _initHive() async{
  await Hive.initFlutter();
  await Hive.openBox("paymentResult");
}




// class MyApp extends StatelessWidget{
// const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: "Test App",
//       theme: ThemeData.from(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const HomePage(),
//     );
//   }
// }
