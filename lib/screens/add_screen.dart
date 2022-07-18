import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainemployee/cubit/cubit_add_screen.dart';
import 'package:trainemployee/cubit/states.dart';


class AddScreen extends StatelessWidget {
  final isUpdate;
  final index;
  final name;
  final age;
  final city;
  final dep;
  final desc;
  AddScreen(this.isUpdate,{this.index,this.name,this.age,this.city,this.dep,this.desc});


  var nameCont = TextEditingController();
  var ageCont = TextEditingController();
  var cityCont = TextEditingController();
  var departCont = TextEditingController();
  var descCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    if(isUpdate){
      nameCont.text =name;
      ageCont.text=age;
      cityCont.text=city;
      departCont.text=dep;
      descCont.text=desc;
    }
    return BlocConsumer<AddCubit,EmployeeState>(
    listener: (context, state) {},
    builder:(context, state){
      var cubit = AddCubit.get(context);
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        label: Text('Name'),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'title must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: ageCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        label: Text('Age'),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Age must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: cityCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        label: Text('City'),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'city must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: departCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.dashboard),
                        label: Text('Department'),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Department must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: descCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.details),
                        label: Text('Descreption'),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                           if(!isUpdate){
                             cubit.insertToDb(
                                 name: nameCont.text,
                                 age: ageCont.text,
                                 city: cityCont.text,
                                 dep: departCont.text,
                                 desc: descCont.text,
                                 context: context
                             ).then((val){
                               Navigator.pop(context);
                               //  cubit.changeScreen();
                             });
                           }
                           else if(isUpdate){
                           cubit.updateData(
                               id:index,
                           name: nameCont.text,
                           age: ageCont.text,
                           city: cityCont.text,
                           dep: departCont.text,
                           desc: descCont.text,
                           context: context
                           ).then((val){
                          Navigator.pop(context);
                          //  cubit.changeScreen();
                          });
                            }
                          }
                        },
                        child: isUpdate? Text('Update'): Text('Add'))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    );

  }
}
