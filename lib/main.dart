import 'package:flutter/material.dart';

import 'todo_item.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'My App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _titleInputController = TextEditingController();
  TextEditingController _subtitleInputController = TextEditingController();

  final List<Todo> todos = [];

  void showCompletedTasks() {
    var complete = todos.where((item) => item.checked).toList();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Success",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: ListView.separated(
            itemCount: complete.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.0);
            },
            itemBuilder: (BuildContext context, int index) {
              return
                new TodoItem(complete[index]);
            }),
      );
    }));
  }


  void showAddingDialog(BuildContext context) {
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Todo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _titleInputController,
                  decoration: InputDecoration(hintText: "Todo title"),
                ),
                TextField(
                  controller: _subtitleInputController,
                  decoration: InputDecoration(hintText: "Todo subtitle"),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Add"),
                onPressed: () {
                  var newTodo = Todo(_titleInputController.text,
                      _subtitleInputController.text);
                  setState(() {
                    todos.add(newTodo);
                  });

                  _titleInputController.clear();
                  _subtitleInputController.clear();
                  Navigator.of(context).pop();
                },
              ),

              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _titleInputController.clear();
                  _subtitleInputController.clear();
                  Navigator.of(context).pop();
                },
              )

            ],

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var incomplete = todos.where((item) => !item.checked).toList();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 24.0,
              fontWeight: FontWeight.bold),

        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: ListView.separated(
          itemCount: incomplete.length,
          separatorBuilder: (BuildContext contrxt, int index) {
            return Divider(height: 1.0);
          },

          itemBuilder: (BuildContext context, int index) {
            return new TodoItem(incomplete[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddingDialog(context);
        },
        child: Icon(Icons.add),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Spacer(),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: showCompletedTasks,
            )
          ],
        ),
      ),
    );
  }
}

