import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/pages/note_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final Function(BuildContext)? onDeletePressed;
  const NoteTile({super.key, this.onDeletePressed, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed:
                  (context) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(oldNote: note),
                      ),
                    ),
                  },
              icon: Icons.edit,
              label: 'Edit',
              backgroundColor: Colors.yellow.shade800,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: onDeletePressed,
              icon: Icons.delete,
              label: 'Delete',
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(7),
          ),

          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(oldNote: note),
                ),
              );
            },
            child: ListTile(title: Text(note.text, maxLines: 3)),
          ),
        ),
      ),
    );
  }
}
