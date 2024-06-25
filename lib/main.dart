import 'package:Easy/pages/auth%20pages/LoginPage.dart';
import 'package:Easy/provider/helper/Dependency_Injection.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Model/Hive/HivePrivateChatModel.dart';
import 'common/utils/colors.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Hive.initFlutter();
  Hive.registerAdapter(HivePrivateChatModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: DependencyInjection(),
      theme: ThemeData(
        fontFamily: "OpenSans",
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF128C7E),
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: secondary,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
