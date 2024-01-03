import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academia/New%20folder/common/error_page.dart';
import 'package:academia/New%20folder/common/loading_page.dart';
import 'package:academia/New%20folder/features/auth/controller/auth_controller.dart';
import 'package:academia/New%20folder/features/auth/view/signup_view.dart';
import 'package:academia/New%20folder/features/home/view/home_view.dart';
import 'package:academia/New%20folder/theme/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("Habit_Database");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'academia',
      debugShowCheckedModeBanner: false,
      // theme: PTheme.lightTheme,
      // darkTheme: PTheme.darkTheme,
      themeMode: ThemeMode.dark,
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (error, st) => ErrorPage(
              error: error.toString(),
            ),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
