import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bloc/bloc.dart';
import 'package:trainemployee/cubit/states.dart';

import '../component/constant.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(EmployeeState initialState) : super(initialState);

  static EmployeeCubit get(context) => BlocProvider.of(context);

//  late Database database;
  List<dynamic> employee = [];
  onCreate() {
    openDatabase('employee.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
        'CREATE TABLE employee (id INTEGER PRIMARY KEY ,name TEXT, age TAXT, city TEXT, depart TEXT , desc TEXT)',
      )
          .then((value) {
        print('table created');
      }).catchError((e) => print('ERROR HAPENED WHILE CREATE TABLE IS $e'));
    }, onOpen: (database) {
      print('database opened');
      getData(database);
    }).then((value) {
      database = value;
      emit(CreateState());
    }).catchError((e) => print('ERROR HAPENED WHILE CREATE database IS $e'));
  }

  getData(data) async {
    await data.rawQuery('SELECT * FROM employee').then((value) {
      employee = value;
      print('DATA RECIEVED IS $employee');
      emit(GetState());
    });
  }


  void deleteData(int id)async{
    await database.rawDelete('DELETE FROM employee WHERE id=?', [id]).then((value){
         print('$value DELETED SUCCESSFULY');
         getData(database);
         emit(DeleteState());
     });
  }

}
