import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
    );
  }
}
