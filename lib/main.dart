import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/controllers/notifiers/theme_notifier.dart';
import 'package:todo_app/controllers/services/database.dart';
import 'package:todo_app/views/screens/main_page.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase();
  const SharedPreferencesAsyncAndroidOptions options =
      SharedPreferencesAsyncAndroidOptions(
          backend: SharedPreferencesAndroidBackendLibrary.SharedPreferences,
          originalSharedPreferencesOptions:
              AndroidSharedPreferencesStoreOptions(fileName: 'darkMode'));
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: isDarkMode ?? false ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
