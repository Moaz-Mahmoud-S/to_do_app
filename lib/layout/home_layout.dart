import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/components/static.dart';
import 'package:todoapp/module/archived_tasks/arch_task.dart';
import 'package:todoapp/module/delete_tasks/delete_task.dart';
import 'package:todoapp/module/done_tasks/new_task.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget
{



  var Scafooldstate = GlobalKey <ScaffoldState>();
  var tcontrol = TextEditingController();
  var tcontrol1 = TextEditingController();
  var tcontrol2 = TextEditingController();
  var formkey = GlobalKey <FormState>();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context , ) => AppCubit()..createdatabase(),
      child: BlocConsumer <AppCubit ,AppStates>(
        listener:(BuildContext context ,AppStates states ) {
          if (states is AppDBinsertState)
            {
              Navigator.pop(context);
            }
          if (states is AppbottomstatusState)
          {
            Navigator.pop(context);
          }
        } ,
        builder: (BuildContext context ,AppStates states )
        {
          return Scaffold(
            key: Scafooldstate,
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton
              (
              backgroundColor: Colors.blueGrey[900],
              child: AppCubit.getappcubitobject(context).i1,
              onPressed: () {
                if (AppCubit.getappcubitobject(context).isbottomsheetshown) {
                  if (tcontrol.text.isNotEmpty && tcontrol1.text.isNotEmpty &&
                      tcontrol2.text.isNotEmpty) {
                    print("c1: " + tcontrol.text + "\n");
                    print("c2: " + tcontrol1.text + "\n");
                    print("c3: " + tcontrol2.text + "\n");
                    AppCubit.getappcubitobject(context).insert_db(tittle: tcontrol.text, date: tcontrol1.text, time: tcontrol2.text);
                    AppCubit.getappcubitobject(context).cleancontrollers(tcontrol,tcontrol1,tcontrol2);
                  }
                  else
                    AppCubit.getappcubitobject(context).changestate(false);
                }
                else {
                  AppCubit.getappcubitobject(context).changeicon(Icon(Icons.edit,color: Colors.white));
                  Scafooldstate.currentState!.showBottomSheet((context) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.grey[300],
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: tcontrol,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  validator: (String ? value) {
                                    if (value!.isEmpty) {
                                      print("not allowed to be empty");
                                    }
                                  },
                                  decoration: InputDecoration
                                    (
                                    labelText: "Task",
                                    prefixIcon: Icon(Icons.title),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: () {
                                    showTimePicker(context: context,
                                        initialTime: TimeOfDay.now()).then((value) =>
                                    tcontrol1.text =
                                        value!.format(context).toString());
                                  },
                                  controller: tcontrol1,
                                  keyboardType: TextInputType.datetime,
                                  validator: (String ? value) {
                                    if (value!.isEmpty) {
                                      print("not allowed to be empty");
                                    }
                                  },
                                  decoration: InputDecoration
                                    (
                                    labelText: "Time",
                                    prefixIcon: Icon(Icons.watch_later),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: () {
                                    showDatePicker(

                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2035-01-01")).then((
                                        value) =>
                                    {
                                      tcontrol2.text =
                                          DateFormat.yMMMd().format(value!)
                                    });
                                  },
                                  controller: tcontrol2,
                                  keyboardType: TextInputType.datetime,
                                  validator: (String ? value) {
                                    if (value!.isEmpty) {
                                      print("not allowed to be empty");
                                    }
                                  },
                                  decoration: InputDecoration
                                    (
                                    labelText: "Date",
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                  ).closed.then((value) {
                    AppCubit.getappcubitobject(context).changeiconandstate(false,Icon(Icons.edit,color: Colors.white));
                  });
                  AppCubit.getappcubitobject(context).changeiconandstate(true,Icon(Icons.add,color: Colors.white));
                }
              },
            ),
            body:  AppCubit.getappcubitobject(context).screens[AppCubit.getappcubitobject(context).index],
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(AppCubit.getappcubitobject(context).tittle[AppCubit.getappcubitobject(context).index],style: TextStyle(color: Colors.white),),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              selectedFontSize: 20,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedLabelStyle: TextStyle(color: Colors.white),
              currentIndex: AppCubit.getappcubitobject(context).index,
              onTap: (currentindex) {
                AppCubit.getappcubitobject(context).BottomNavBarState(currentindex);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu,color: Colors.white60,), label: "Task"),
                BottomNavigationBarItem(icon: Icon(Icons.done,color: Colors.white60,), label: "Done"),
                BottomNavigationBarItem(icon: Icon(Icons.archive,color: Colors.white60,), label: "Archive"),
              ],
            ),
          );
        },
      ),
    );
  }






}
