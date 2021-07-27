import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  //데이터 넘겨주는 곳
  late final String? title;
  late final String? des;

  TaskCardWidget({this.title, this.des});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              des ?? "No description added",
              style: TextStyle(
                  color: Color(0xFF86829D), fontSize: 16.0, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
