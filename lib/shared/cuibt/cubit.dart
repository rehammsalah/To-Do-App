import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks.dart';
import 'package:todo/modules/done_tasks.dart';
import 'package:todo/modules/tasks.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/cuibt/states.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());
  static AppCubit get (context) => BlocProvider.of(context);
  int index = 0;

  List<Widget> classes = [task(), done(), archived()];
  List<String> names = ['Todo', 'Done tasks', 'Archived tasks'];



  void ChangeItem(int ind){
    index=ind;
    emit(ChangeBottomNavBarItemState());
  }
  List<Map> Donetasks = [];
  List<Map> Newtasks = [];
  List<Map> Archivedtasks = [];
  Database database;
  void createdb()  {
   openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('db created');
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error happened : $error');
          });
        },
        onOpen: (database) {
          getdb(database);
        }).then((value) {

          database=value;
          emit(CreateDBState());


   });
  }

   inserttodb(
      {@required String title,
        @required String time,
        @required String date}) async {
     await database.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")',
      ).then((value) {

        emit(InsertToDBState());
        getdb(database);

      });
      return null;
    });
  }


   void getdb (Database database) {

     Donetasks = [];
     Newtasks = [];
     Archivedtasks = [];

    emit(GetDBLoadingState());
   database.rawQuery('SELECT * FROM tasks').then((value) {


    value.forEach((element)
    {
      if(element['status']=='New')
        Newtasks.add(element);
      else if(element['status']=='Done')
        Donetasks.add(element);
      else
        Archivedtasks.add(element);


    });
     emit(GetDBState());
   });


  }

  bool nobuttonpressed = false;
  IconData icontogel = Icons.add;

  void ChangeBottomSheetState(
      IconData icon ,
      bool nopressed,)
  {
    nobuttonpressed= nopressed;
    icontogel=icon;
    emit(AppChangeBottomSheetState());
  }

  void Updatedb(
      {
  @required String status,
        @required int id
})
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id= ?',
      ['$status',id],
    ).then((value){
      getdb(database);
      emit(UpdateDBState());
    } );

}
  void Deletedb(
      {
        @required int id
      })
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',[id])
     .then((value){
      getdb(database);
      emit(DeleteFromDBState());
    } );

  }

}


