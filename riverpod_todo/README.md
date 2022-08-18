# riverpod_todo

Todo app with Riverpod for state management and talking to the database. 
SQLite database (sqflite package) is used for storage on mobile, and 
[Mock repository](lib/repositories/mock_repo.dart) for testing on desktop.

Currently Riverpod doesn't update the HomePage after updates to the Todo List 
on Windows for any reason.
