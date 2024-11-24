import 'package:camera/camera.dart';
import 'package:famscreen/pages/RegisterPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/HomePage.dart';
import 'utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mendapatkan kamera
  _cameras = await availableCameras();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'FamScreen',
      theme: customTheme,
      home: RegisterPage(),
    );
  }
}
