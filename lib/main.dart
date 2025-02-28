import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/data/api/api_service.dart';
import 'package:suitmedia_test/provider/selected_user_provider.dart';
import 'package:suitmedia_test/provider/user_provider.dart';
import 'package:suitmedia_test/routes/navigation.dart';
import 'package:suitmedia_test/screens/first/first_screen.dart';
import 'package:suitmedia_test/screens/second/second_screen.dart';
import 'package:suitmedia_test/screens/third/third_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ChangeNotifierProvider(
          create: (context) => UserProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(create: (_) => SelectedUserProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suitmedia Test',
      debugShowCheckedModeBanner: false,
      initialRoute: Navigation.firstScreen.name,
      routes: {
        Navigation.firstScreen.name: (context) => const FirstScreen(),
        Navigation.secondScreen.name:
            (context) => SecondScreen(
              name: ModalRoute.of(context)?.settings.arguments as String,
            ),
        Navigation.thirdScreen.name: (context) => const ThirdScreen(),
      },
    );
  }
}
