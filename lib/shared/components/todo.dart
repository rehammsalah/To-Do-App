import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/cuibt/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool clickable= true,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  enabled:clickable ,
  onTap: onTap,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? Icon(
      suffix,
    ) : null,
    border: OutlineInputBorder(),
  ),
);

Widget taskitem(Map model, context)=> Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direcion){
    AppCubit.get(context).Deletedb(id: model['id']);

  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Container(


      decoration: BoxDecoration(
          color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(20))
        
      ),

      child: Row(


        children: [
          SizedBox(
            width: 20,
          ),

          Container(

            color: Colors.blue,
            child: SizedBox(height: 80,
              width: 10,
            )

    )

          ,


          SizedBox(width: 20,),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [

                Text(

                  '${model['title']}',

                  style: TextStyle(

                    fontSize: 20,
                      fontWeight: FontWeight.bold

                  ),

                ),

                Text(

                  '${model['date']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),



              ],



            ),

          ),

          SizedBox(width: 20,),

          IconButton(

              icon: Icon(Icons.check_box),
              color: Colors.grey,

              onPressed: (){



                   AppCubit.get(context).Updatedb(status: 'Done', id: model['id']);

  }



          ),

          IconButton(

              icon: Icon(Icons.archive_outlined),

              onPressed: (){



                       AppCubit.get(context).Updatedb(status: 'Archived', id: model['id']);

              }



          ),

        ],



      ),
    ),

  ),
);

Widget ConditionEmptyTabs({
  @required List<Map>tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=>ListView.separated(
      itemBuilder: (context, index)=>taskitem(tasks[index],context),
      separatorBuilder:(context, index)=>Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
      itemCount: tasks.length
  ),
  fallback: (context)=>Center(

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.note_add_outlined,size: 100,color: Colors.grey,),

        SizedBox(height: 10,),
        Text('No tasks yet, Please enter some tasks',
          style: TextStyle(
              fontSize: 20,
          fontWeight: FontWeight.bold,
            color: Colors.grey,


          )

          ,)

      ],

    ),
  ),

);
