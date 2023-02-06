import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/azkar_app/cubit/states.dart';

class cubitazkar extends Cubit<azkar>
{
  cubitazkar():super(initazkar());
  static cubitazkar get(context) => BlocProvider.of(context);




}