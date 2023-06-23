import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';  //ımport page that we created

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {  //for search bar section found what user want 
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),  //IT CALLS AppBar _buildAppBar() ABOVE
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(  //WE ARE ADDING SEARCH BUTTON SECTION WITH COLUMN
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)   //when user add something with .reversed it will be in the beginning on the list 
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,  //controls the state of the todo item 
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(   //adding operation uı section
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(  //adding section's buttom field
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);   //it will call this method for clear the operation text section 
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {  //functionality of the page use when the state is change of the todo type 
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {  //we need to focus on the id  of the item.
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {  //ıt will call this method when pressing add buttom
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),  //it must we unique so we are controlling with milliseconds item
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {  //FOR THE SEARCH BAR USE IT 
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;  //ıf nothing write do nothing just shows available items
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()  //if user write something convert it first 
              .contains(enteredKeyword.toLowerCase()))
          .toList();  
    }

    setState(() {
      _foundToDo = results;  //then provide the results which we have found 
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,  //GET RID OF BORDER OF SEARCH BOX
          hintText: 'Search',  //DEFAULT TEXT
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,  //FOR UI SHADOW HAS BEEN GONE
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,  //LEFT MENU BAR SECTION OF UI
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,  //IN THE CONTAINER SECTION WE CHANGE THE SIZE OF THE PICTURE
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),  //TO MAKE IT CIRCULAR
            child: Image.asset('assets/images/avatar.jpeg'),  //WE HAVE CREATED IMAGE ON THE MENU
          ),
        ),
      ]),
    );
  }
}
