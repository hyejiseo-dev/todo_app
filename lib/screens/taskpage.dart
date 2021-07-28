import 'package:flutter/material.dart';
import 'package:startapp/database_helper.dart';
import 'package:startapp/models/task.dart';
import 'package:startapp/models/todo.dart';
import 'package:startapp/widget.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<TaskPage> {
  int _taskId = 0;
  String _taskTitle = '';

  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  void initState(){
    if(widget.task != null){
      _taskTitle = widget.task!.title!;
      _taskId = widget.task!.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                         // print("Clicked Back Button...");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                            image: AssetImage('assets/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async{
                            // 타이틀 값이 없을 때는 데이터베이스에 넣지 않음
                            if(value != ''){
                              if(widget.task == null){
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Task _newTask = Task(
                                    title: value
                                );
                                await _dbHelper.insertTask(_newTask);
                              }else{
                                print('update the exsiting task');
                              }
                            }
                          }, //리스트를 누르면 해당 내용이 나오는 컨트롤러
                          controller: TextEditingController()..text = _taskTitle,
                          decoration: InputDecoration(
                            hintText: "Enter Task Title..",
                            border : InputBorder.none
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211511)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Description for the task...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0
                      )
                    ),
                  ),
                ),
               FutureBuilder(
                 initialData: [],
                 future: _dbHelper.getTodo(_taskId),
                 builder: (context, AsyncSnapshot snapshot){
                   return Expanded(
                     child: ListView.builder(
                       itemCount: snapshot.data.length,
                       itemBuilder: (context, index){
                         return GestureDetector(
                           onTap: (){
                             //Switch todo completion state
                           },
                           child: TodoWidget(
                             text: snapshot.data[index].title,
                             isDone: snapshot.data[index].isDone == 0 ? false : true,
                           ),
                         );
                       },

                     ),
                   );
                 },

               ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        margin: EdgeInsets.only(
                            right: 12.0
                        ),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: Color(0xFF868290),
                                width: 1.5
                            )
                        ),
                        child: Image(
                          image: AssetImage(
                              'assets/check_icon.png'
                          ),
                        ) ,
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async{
                            // 타이틀 값이 없을 때는 데이터베이스에 넣지 않음
                            if(value != ''){
                              if(widget.task != null){
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Todo _newTodo = Todo(
                                    title: value,
                                    isDone: 0,
                                    taskId: widget.task!.id,
                                );
                                await _dbHelper.insertTodo(_newTodo);
                                setState(() {});
                              }else{
                                print("Task not exist");
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Todo item...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage(task: null,)));
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFFE3577),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image(
                      image: AssetImage('assets/delete_icon.png'),
                    ),
                  ),
                ),
              )
          ]
          ),
        ),
      ),
    );
  }
}
