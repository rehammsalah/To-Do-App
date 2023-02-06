import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/cubit/cubit.dart';
import 'package:todo/modules/cubit/states.dart';

class CounterScreen extends StatelessWidget
{



@override
Widget build(BuildContext context) {


  return BlocProvider(


    create: (BuildContext context)=>Countercubit(),
    child: BlocConsumer<Countercubit,Counterstates>(

      listener: (context,state){

        if(state is Counterplusstate)
          {
            print('${state.counter}');

          }
        if(state is Counterminusstate)
        {

          print('${state.counter}');

        }
      },
      builder:(context,state){

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Counter',
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: ()
                  {
                    Countercubit.get(context).minus();
                  },
                  child: Text(
                    'MINUS',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    '${Countercubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: ()
                  {
                    Countercubit.get(context).plus();
                  },
                  child: Text(
                    'PLUS',
                  ),
                ),
              ],
            ),
          ),
        );
      },

    )
  );
}
}
