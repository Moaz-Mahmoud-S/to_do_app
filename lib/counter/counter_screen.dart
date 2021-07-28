import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counterstate.dart';
import 'cubit/cubit.dart';

class CountScreen extends StatelessWidget {

  int counter=1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer <CounterCubit , CounterStates>(
        listener: (context ,state ){},
        builder: (context , state) =>  SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("counter"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            CounterCubit.getcountercubit(context).plus();
                          },
                          child: Text("+",style: TextStyle(fontSize: 30),),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${CounterCubit.getcountercubit(context).counter}",
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            CounterCubit.getcountercubit(context).minus();
                          },
                          child: Text("-",style: TextStyle(fontSize: 30),),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
