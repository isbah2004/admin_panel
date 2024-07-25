import 'package:admin_panel/homescreen/home_screen.dart';
import 'package:admin_panel/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhoneProvider()),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
