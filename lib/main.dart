import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/task_bloc.dart';
import 'package:todo_list/repositories/task_repository.dart';
import 'package:todo_list/screens/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repository = TaskRepository();
  MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(repository),
      child: MaterialApp(
        title: 'TODO List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
