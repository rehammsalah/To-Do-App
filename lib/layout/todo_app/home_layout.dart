import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/components/todo.dart';
import 'package:todo/shared/cuibt/cubit.dart';
import 'package:todo/shared/cuibt/states.dart';
import 'file:///C:/Users/reham/IdeaProjects/todo/lib/modules/archived_tasks.dart';
import 'file:///C:/Users/reham/IdeaProjects/todo/lib/modules/tasks.dart';

import '../../modules/done_tasks.dart';

class home extends StatelessWidget {


  var scaffoldkey = GlobalKey<ScaffoldState>();
   var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createdb(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {

          if (state is InsertToDBState)
            {

              Navigator.pop(context);

            }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.names[cubit.index]),
            ),
            body: ConditionalBuilder(
              condition: true ,
              builder: (context) => cubit.classes[cubit.index],
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
              onTap: (int ind) {
                cubit.ChangeItem(ind);
              },
              currentIndex: cubit.index,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.icontogel),
              onPressed: () {
                if (cubit.nobuttonpressed) {
                  if (formkey.currentState.validate()) {
                   cubit.inserttodb(
                       title: titlecontroller.text,
                       time: timecontroller.text,
                       date: datecontroller.text);
                  }
                } else {
                  scaffoldkey.currentState.showBottomSheet((context) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: titlecontroller,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value
                                        .toString()
                                        .isEmpty) {
                                      return 'please enter the title';
                                    }
                                    return null;
                                  },
                                  label: 'Task title',
                                  prefix: Icons.title,
                                  onTap: () {}),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: timecontroller,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value
                                        .toString()
                                        .isEmpty) {
                                      return 'please enter the time';
                                    }
                                    return null;
                                  },
                                  label: 'Task time',
                                  prefix: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timecontroller.text =
                                          value.format(context).toString();
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: datecontroller,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value
                                        .toString()
                                        .isEmpty) {
                                      return 'please enter the date';
                                    }
                                    return null;
                                  },
                                  label: 'Task date',
                                  prefix: Icons.date_range,
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-12-01'))
                                        .then((value) =>
                                    {
                                      datecontroller.text =
                                          DateFormat.yMd().format(value)
                                    });
                                  })
                            ],
                          ),
                        ),
                      )).closed.then((value) {
                cubit.ChangeBottomSheetState(Icons.add, false);

                  });

                  cubit.ChangeBottomSheetState(Icons.done, true);

                }

              },

            ),
          );
        },


      ),


    );
  }

}
