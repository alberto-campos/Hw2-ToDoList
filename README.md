Homework assignment 2 -- Simple ToDo app
====================================

**Using CodePath bootcamp_ToDo App **

This app allows the user to enter a new task and hit enter or click 'Add' to store the new task. This task is using PList to store the user's data. To modify a new task the user simply clicks the task inside a cell and clicks the "Modify" link. Per design, the 'enter' key will be saved as a new line, it won't save the task.

## Features
    A user may add a new to do item inline
    A user may edit a to do item inline
    A user may delete a to do item
    A user may rearrange the order of to do items
    To Do items are immediately saved after being edited
    Saved To Do items are loaded on launch
    Allow to do items to span multiple lines.  Table rows should grow and shrink as appropriate.
    Sync the todo items with Parse (optional). (Pending, currently using plist)

## Usage

When you launch the app for the first time there will be only one task by default. If removed, the page will be empty.

Notice the keyboard appears automatically and the focus is set to the text field to add a new task. To dismiss the keyboard simply hit enter and leave the text field blank.

![Launching app](https://github.com/alberto-campos/Hw2-ToDoList/tree/752cb654d64ef9ba72947193e50c756dc1579f34/todo-startWithKeyboardEnabled.png)

If a tasks is longer than the default cell height, then the app will adjust the cell. Notice that the cell won't be adjusted while the text is been edited.
![Long name](https://github.com/alberto-campos/Hw2-ToDoList/tree/752cb654d64ef9ba72947193e50c756dc1579f34/todo-Long task.png)

While editing,the 'Add' button becomes enabled and the keyboard becomes visible.
![Behavior while editing](https://github.com/alberto-campos/Hw2-ToDoList/tree/752cb654d64ef9ba72947193e50c756dc1579f34/todo-Editing.png)
