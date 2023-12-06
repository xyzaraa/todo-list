import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/route_manager.dart';
import 'package:note_keep/providers/todo_provider.dart';
import 'package:note_keep/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('656598fa5c88eef897f7')
      .setSelfSigned(status: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: SplashScreen(),
      ),
    );
  }
}
