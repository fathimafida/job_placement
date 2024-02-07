import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/app_theme.dart';
import 'package:job_placement/features/addPost/cubit/cubit/add_edit_job_post_cubit.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/views/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getHomeData()),
        BlocProvider(create: (context) => AddEditJobPostCubit()),
      ],
      child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: HomeView()),
    );
  }
}