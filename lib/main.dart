import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Colors.yellow),
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todos = [];
  TextEditingController todoController = TextEditingController();
  TextEditingController editTodoController = TextEditingController();
  int editingIndex = -1;

  void addTodo() {
    setState(() {
      todos.add(todoController.text);
      todoController.clear();
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
      if (editingIndex == index) {
        editingIndex = -1;
      }
    });
  }

  void startEditing(int index) {
    setState(() {
      editingIndex = index;
      editTodoController.text = todos[index];
    });
  }

  void saveEdit() {
    setState(() {
      todos[editingIndex] = editTodoController.text;
      editTodoController.clear();
      editingIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      labelText: 'Add a TODO',
                      labelStyle: TextStyle(color: Colors.yellow),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.yellow,
                  onPressed: addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: editingIndex == index
                      ? TextField(
                          controller: editTodoController,
                          decoration: InputDecoration(
                            labelText: 'Edit TODO',
                            labelStyle: TextStyle(color: Colors.yellow),
                          ),
                        )
                      : Text(
                          todos[index],
                          style: TextStyle(color: Colors.yellow),
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (editingIndex == index)
                        IconButton(
                          icon: Icon(Icons.check),
                          color: Colors.green,
                          onPressed: saveEdit,
                        )
                      else
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.yellow,
                          onPressed: () => startEditing(index),
                        ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.yellow,
                        onPressed: () => removeTodo(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
