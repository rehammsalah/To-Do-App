import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/components/todo.dart';
import 'package:todo/shared/cuibt/cubit.dart';
import 'package:todo/shared/cuibt/states.dart';

class done extends StatelessWidget {


  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>
      (



        builder: (context,state){
          var tasks =AppCubit.get(context).Donetasks;
          return  ConditionEmptyTabs(tasks: tasks);

        },


        listener: (context,state){


        }




    );
  }
}