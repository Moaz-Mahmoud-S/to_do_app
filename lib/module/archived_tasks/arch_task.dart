import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:todoapp/components/component_one.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class arch_task_screen extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    AppCubit.archivedtasks=AppCubit.archivedtasks.toSet().toList();
    return BlocConsumer <AppCubit ,AppStates>(
        listener: (BuildContext context , AppStates states){},
        builder: (BuildContext context , AppStates states){
          return Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context)  => AppCubit.archivedtasks.length > 0 ,
              fallbackBuilder: (BuildContext context) { return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu,size: 50,),
                      Text("No Tasks Yet !",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
                    ],
                  ),
                ),
              );},
              widgetBuilder: (BuildContext context) {  return ListView.separated(
                  itemBuilder :(context , index)
                  {
                    return buildtaskitem(AppCubit.archivedtasks[index],context);
                  },
                  separatorBuilder: (context , index)
                  { return Container
                    (
                    color: Colors.blueGrey[700],
                    height: 1,
                    width: double.infinity,
                  );},
                  itemCount: AppCubit.archivedtasks.length);}
          );


        });

  }

  }
