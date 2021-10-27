import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/layout/layout_page.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(CodeModelAdapter());
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(kHiveBox);
  await Hive.openBox('mode');
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QRProvider(),
      child: Builder(builder: (context) {
        context.read<QRProvider>().getMode();
        return MaterialApp(
          title: 'QR and Bar Code Scanner',
          debugShowCheckedModeBanner: false,
          themeMode: context.watch<QRProvider>().isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          theme:
              context.watch<QRProvider>().isDarkMode ? kDarkMode : kLightMode,
          home: const LayoutPage(),
        );
      }),
    );
  }
}
