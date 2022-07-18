import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainemployee/cubit/cubit_logic.dart';
import 'package:trainemployee/screens/home_screen.dart';

import 'cubit/cubit_add_screen.dart';
import 'cubit/states.dart';
import 'models/employee.dart';

void main() {
  BlocOverrides.runZoned(() {
    runApp(MyApp());
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> EmployeeCubit(InitialState())..onCreate(),),
        BlocProvider(create: (context)=> AddCubit(InitialState()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,

        ),
        home: HomeScreen(),
      ),
    );
  }
}
