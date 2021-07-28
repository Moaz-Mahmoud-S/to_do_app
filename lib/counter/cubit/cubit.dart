import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterstate.dart';

 class CounterCubit extends Cubit <CounterStates>
{
  int counter =0;
  CounterCubit() : super(Initcountscreen());
 static CounterCubit getcountercubit (BuildContext context) => BlocProvider.of(context);

 void minus ()
 {
   counter--;
   emit(counterminusstate());
 }
  void plus ()
  {
    counter++;
    emit(counterplusstate());
  }


}