import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:trainemployee/cubit/cubit_logic.dart';
import 'package:trainemployee/screens/add_screen.dart';

Widget ListCard({
  required int id,
  required String name,
  required String age,
  required String city,
  required String department,
  required context,
  String? desc,
}) =>
    Dismissible(
      key: UniqueKey(),
      onDismissed: (dir) {
        EmployeeCubit.get(context).deleteData(id);
      },
      child: ListTile(
        title: Text(name),
        subtitle: Text('$city - $age - $department'),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddScreen(
                            true,
                            index: id,
                        name: name,
                        age: age,
                        city: city,
                         dep: department,
                        desc: desc,
                          )));
            },
            icon: Icon(Icons.edit)),
      ),
    );

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
