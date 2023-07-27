import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/login/login_screen.dart';
import 'package:btech_induction_2023/view/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InductionApp extends StatelessWidget {
  const InductionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseFirestoreService>(
          create: (_) => FirebaseFirestoreService(),
        ),
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'B.Tech Induction App',
        theme: InductionAppTheme.dark,
        home: const LoginScreen(),
      ),
    );
  }
}
