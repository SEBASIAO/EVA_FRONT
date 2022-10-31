import 'package:eva/providers/company_provider.dart';
import 'package:eva/providers/cv_provider.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/screens/screens.dart';
import 'package:eva/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CvProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVA',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'main': (context) => MainScreen(),
        'details': (context) => CvDetailScreen(),
        'companies': (context) => CompaniesScreen(),
        'companyDetail': (context) => CompanyDetail(),
        'register': (context) => RegisterUserScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
