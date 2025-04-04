import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/visits/data/repositories/visit_repository_impl.dart';
import 'feature/visits/presentation/bloc/visits_bloc.dart';
import 'feature/visits/presentation/screens/visits_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10Mark Capital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4051B5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4051B5),
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => VisitsBloc(
          repository: VisitRepositoryImpl(),
        )..add(LoadVisits()),
        child: const VisitsScreen(),
      ),
    );
  }
}

