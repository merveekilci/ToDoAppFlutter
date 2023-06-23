import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
//we have created this for all todo section
  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('Clicked on Todo Item.');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(  //wıth leadıng attribute add ıcon like delete
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,  //controls done sections uı checkbox 
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,   //todo text section we change it to the dynamic 
          style: TextStyle(  //at first it will go to the todo class then find todoText section from the todo.dart
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,   //if the item is done then change text decoration
          ),
        ),  
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),   //delete ıcon we will customıze it
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(todo.id);  //when user press the button it will call this method from home.dart
            },
          ),
        ),
      ),
    );
  }
}
