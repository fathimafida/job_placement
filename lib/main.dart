import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/app_theme.dart';
import 'package:job_placement/features/add_edit_job_post/cubit/cubit/manage_job_cubit.dart';
import 'package:job_placement/features/auth/cubit/auth_cubit.dart';
import 'package:job_placement/features/auth/cubit/register_cubit.dart';
import 'package:job_placement/features/auth/views/auth_screen.dart';

import 'package:job_placement/features/home/cubit/job_home_cubit.dart';
import 'package:job_placement/features/home/views/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JobHomeCubit()),
        BlocProvider(create: (context) => ManageJobCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: AuthScreen()),
    );
  }
}
