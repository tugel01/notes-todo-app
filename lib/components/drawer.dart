import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer_tile.dart';
import 'package:flutter_application_1/pages/notes_page.dart';
import 'package:flutter_application_1/pages/settings_page.dart';
import 'package:flutter_application_1/pages/todo_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // header
          const DrawerHeader(child: Icon(Icons.note_alt)),
          // note tile
          DrawerTile(
            title: 'Notes',
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesPage()),
              );
            },
          ),
          
          // todo tile
          DrawerTile(
            title: 'Todo List',
            leading: const Icon(Icons.task),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoPage()),
              );
            },
          ),
          // settings
          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
