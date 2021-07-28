import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/counter/counter_screen.dart';
import 'package:todoapp/shared/block_observer.dart';

import 'layout/home_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeLayout(),
    );
  }
}
