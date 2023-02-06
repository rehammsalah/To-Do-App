import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/cubit/states.dart';

class Countercubit extends Cubit<Counterstates>
{
  Countercubit() : super(Counterinitialstate());
  int counter =1;
  static Countercubit get (context) => BlocProvider.of(context);

  void plus (){


    counter++;
    emit(Counterplusstate(counter));

  }
  void minus (){

    counter--;
    emit(Counterminusstate(counter));
  }


}
