import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';
import 'widgets/app_colors.dart';

void main() => runApp(const LostFoundApp());

class LostFoundApp extends StatelessWidget {
  const LostFoundApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lost & Found',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF8F8FC),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
          fontFamily: 'Roboto',
        ),
        home: const WelcomePage(),
      );
}
