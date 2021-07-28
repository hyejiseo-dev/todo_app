import 'package:flutter/material.dart';
import 'package:startapp/database_helper.dart';
import 'package:startapp/models/task.dart';
import 'package:startapp/widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<TaskPage> {
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
                              DatabaseHelper _dbHelper = DatabaseHelper();
                              Task _newTask = Task(
                                title: value
                              );
                              await _dbHelper.insertTask(_newTask);

                              print('new task has been created');
                            }
                          },
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
                TodoWidget(text: 'Create your First Task',isDone: true,),
                TodoWidget(text: 'Create your First todo as well',isDone: true),
                TodoWidget(isDone: false),
                TodoWidget(isDone: false),
              ],
            ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage()));
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
