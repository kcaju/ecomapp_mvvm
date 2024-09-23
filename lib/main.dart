import 'package:ecomapp_mvvm/model/cart_screen/cart_model.dart';
import 'package:ecomapp_mvvm/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<CartModel>(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
