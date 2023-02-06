import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/modules/counter.dart';
import 'package:todo/shared/block%20observer.dart';
import 'layout/todo_app/home_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(
title: 'reham',
home: home(),
  debugShowCheckedModeBanner: false,
));

}

