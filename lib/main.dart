import 'package:btech_induction_2023/app.dart';
import 'package:btech_induction_2023/firebase_options.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const InductionApp());
}
