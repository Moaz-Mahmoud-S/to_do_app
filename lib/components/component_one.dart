import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget buildbutton(int weight,Function function,Color color, Icon I, String herotag) {
  return FloatingActionButton(
    heroTag: herotag,
      onPressed: function(),
      child: I ,
      mini: true,
      backgroundColor: color
  );}

Widget buildformtextfield (
    {
    required TextEditingController controller,
    required Function validatorfunction,
    required TextInputType T1,
    required String labeltext,
    required Icon c1,}
    )
  {
    return  TextFormField(
      controller: controller,
      obscureText: true,
      validator: validatorfunction(),
      keyboardType: T1,
      decoration: InputDecoration
        (
        labelText: labeltext,
        prefixIcon: c1,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildtaskitem (Map model,context) =>  Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (Direction){
      AppCubit.getappcubitobject(context).deletefromDb(model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Text("${model["date"]}",style: TextStyle (color: Colors.white),),
            radius: 30,
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model["tittle"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              Text("${model["time"]}",style: TextStyle(fontSize: 15,color: Colors.black),)
            ],
          ),
          SizedBox(width: 10,),
          IconButton(onPressed: (){
            AppCubit.getappcubitobject(context).updatedatabase(status: "done", id: model['id']);
          }, icon: Icon (Icons.check_box),),
          IconButton(onPressed: (){
            AppCubit.getappcubitobject(context).updatedatabase(status: "archive", id: model['id']);
          }, icon: Icon (Icons.archive)),
        ],
      ),
    ),
  );