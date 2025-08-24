import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_cubit_guide/app/app.dart';
import 'package:flutter_clean_architecture_cubit_guide/app/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await Injector.init();
  
  runApp(const App());
}
