import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainemployee/cubit/cubit_logic.dart';
import 'package:trainemployee/cubit/states.dart';

import '../component/constant.dart';

class AddCubit extends Cubit<EmployeeState> {
  AddCubit(EmployeeState initialState) : super(initialState);

  static AddCubit get(context) => BlocProvider.of(context);

//  Database? database;
//  onCreate() {
//    openDatabase(
//      'employee.db',
//      version: 1,
//    ).then((value) {
//      database = value;
//      emit(CreateState());
//    }).catchError((e) => print('ERROR HAPENED WHILE CREATE database IS $e'));
//  }

  insertToDb({
    required String name,
    required String age,
    required String city,
    required String dep,
    required String desc,
    required context
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO employee(name,age,city,depart,desc) VALUES ("$name","$age","$city","$dep","$desc")')
          .then((value) {
        print('$value inserted successfuly');
        emit(InsertState());
        EmployeeCubit.get(context).getData(database);
      }).catchError((e) => print('ERROR HAPENED WHILE INSERT IS $e'));
    });
  }




  updateData({
    required int id,
    required String name,
    required String age,
    required String city,
    required String dep,
    required String desc,
    required context
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawUpdate(
          'UPDATE employee SET name=?,age=?,city=?,depart=?,desc=?  WHERE id=?', ["$name","$age","$city","$dep","$desc",id])
          .then((value) {
        print('$value updated successfuly');
        emit(UpdateState());
        EmployeeCubit.get(context).getData(database);
      }).catchError((e) => print('ERROR HAPENNED WHILE INSERT IS $e'));
    });
  }
}
