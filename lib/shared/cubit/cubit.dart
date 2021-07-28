import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/module/archived_tasks/arch_task.dart';
import 'package:todoapp/module/delete_tasks/delete_task.dart';
import 'package:todoapp/module/done_tasks/new_task.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  late Database database;
  Icon i1 = Icon(Icons.add,color: Colors.white);
  bool isbottomsheetshown = false;
  static List <Map> newtasks=[];
  static List <Map> donetasks=[];
  static List <Map> archivedtasks=[];

  List<Widget> screens = [
    new_task_screen(),
    delete_task_screen(),
    arch_task_screen()
  ];
  List<String> tittle = ["Tasks", "Delete Task", "Archived Task"];
  int index = 0;

  AppCubit() : super(AppIntiateState());

  static AppCubit getappcubitobject(BuildContext context) =>
      BlocProvider.of(context);

  void BottomNavBarState(int currentindex) {
    index = currentindex;
    emit(AppBottomNavBarState());
  }

  void createdatabase() async {
    await openDatabase("todo.db", version: 1, onCreate: (database, version) {
      database.execute("create table task ( id integer primary key , tittle Text , date Text , time Text , status Text )",).then((value) {
        print("database created");
      }).catchError((error) {
        print("an error occure");
      });}, onOpen: (database) {
      getDataFromDatabase(database);
   /*  database.delete("task");
      print("all data deleted");
      emit(AppDBdeleteeState());*/
      print("database opened");
    }).then((value) {
      emit(AppDBcreateState());
      database = value;
    });
  }

   insert_db(
      {required String tittle,
      required String date,
      required String time}) async {
     await database.transaction((txn) async {
      txn.rawInsert("insert into task (tittle,date,time,status) values ('$tittle','$date','$time','new')").then((value) {
        emit(AppDBinsertState());
        print(" $value data inserted");
        getDataFromDatabase(database);
      }).catchError((error) {});
    });
  }

  getDataFromDatabase(database) async {

    database.rawQuery("Select * from task").then((value)
        {
          newtasks.clear();
          donetasks.clear();
          archivedtasks.clear();
         /* newtasks.toSet().toList();
          archivedtasks.toSet().toList();
          donetasks.toSet().toList();*/
          value.forEach((elemnt)
          {
            if (elemnt['status']=='new')
              newtasks.add(elemnt);
            else if (elemnt['status']=='done')
              donetasks.add(elemnt);
            else
              archivedtasks.add(elemnt);
          });
          print(newtasks.length);
          print(donetasks.length);
          print(archivedtasks.length);
          emit(AppDBgeteState());

        });
  }

  void deletealltasks(database) async {
    database.delete("task");
    print("all data deleted");
  }

  void changeiconandstate (bool state, Icon c1)
  {
    i1=c1;
    isbottomsheetshown=state;
    emit(AppbothState());
  }

  void changeicon (Icon c1) {
    i1 = c1;
    emit(AppicontState());
  }

  void changestate (bool state)
  {
    isbottomsheetshown= state;
    emit(AppbottomstatusState());
  }

  void cleancontrollers (TextEditingController T1,TextEditingController T2,TextEditingController T3)
  {
    T1.clear();T2.clear();T3.clear();
    emit(Appcontrolclear());
  }

  void updatedatabase ({required String status , required int id}) async
  {
    await database.rawUpdate("update task set status = ?  where id= ?",['$status',id]).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDBupdateeState());
    });
  }

  void deletefromDb (int id) async
  {
    await database.rawDelete("delete from task where id = ?",[id]).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDBdeleteerowState());
    });
  }
}
