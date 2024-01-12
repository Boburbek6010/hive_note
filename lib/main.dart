import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_note/pages/detail_page.dart';
import 'package:hive_note/pages/home_page.dart';
import 'package:hive_note/services/hive_service.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        HomePage.id:(context) => const HomePage(),
        DetailPage.id:(context) => const DetailPage(),
      },
    );
  }
}
