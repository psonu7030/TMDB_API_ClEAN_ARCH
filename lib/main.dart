import 'package:flutter/material.dart';
import 'config/theme/app_theme.dart';
import 'features/data/repositories/api/movie_api.dart';
import 'features/presentation/bloc/movie_block.dart';
import 'features/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home:  BlocProvider<MovieBloc>(
        create: (context) => MovieBloc(movieApiService: MovieApi()),
    child:  HomePage( toggleTheme: _toggleTheme,),
    ));
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme; // Toggle theme
    });
  }
}