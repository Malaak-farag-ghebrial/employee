import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainemployee/cubit/cubit_logic.dart';
import 'package:trainemployee/cubit/states.dart';
import 'package:trainemployee/models/employee.dart';
import 'package:trainemployee/screens/add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

        return BlocConsumer<EmployeeCubit,EmployeeState>(
          listener: (context,state){},
          builder:(context,state){
            var cubit = EmployeeCubit.get(context).employee;
          return  Scaffold(

              body: ListView.builder(
                  itemBuilder: (context, index) => ListCard(
                    id:  cubit[index]['id'],
                    name: cubit[index]['name'],
                    age: '${cubit[index]['age']}',
                    city: cubit[index]['city'],
                    department:  cubit[index]['depart'],
                    desc: cubit[index]['desc'],
                    context: context,
                  ) ,
                  itemCount: cubit.length
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> AddScreen(false,)));
                } ,
                child: Icon(Icons.add),
              ),
            );
          },
        );


  }
}
