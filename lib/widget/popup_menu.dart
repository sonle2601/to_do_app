import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;
  const PopupMenu({
    super.key,
    required this.cancelOrDeleteCallback,
    required this.task,
    required this.likeOrDislike,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false ? (context) => [
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: editTaskCallback,
                icon: Icon(Icons.edit),
                label: Text('Edit'),
              )
          ),
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: likeOrDislike,
                icon: task.isFavorite == false
                    ? Icon(Icons.bookmark_add_outlined)
                    : Icon(Icons.bookmark),
                label: task.isFavorite == false
                  ? Text('Add to Bookmark')
                  : Text('Remove from  Bookmark'),
              )
          ),
          PopupMenuItem(
            child: TextButton.icon(
              onPressed: cancelOrDeleteCallback,
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            ),
            // onTap: () => cancelOrDeleteCallback,
          )
        ] : (context) => [
          PopupMenuItem(
            child: TextButton.icon(
              onPressed: restoreTaskCallback,
              icon: Icon(Icons.restore_from_trash),
              label: Text('Restore'),
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: TextButton.icon(
              onPressed: cancelOrDeleteCallback,
              icon: Icon(Icons.delete_forever),
              label: Text('Delete Forever'),
            ),
            // onTap: () => cancelOrDeleteCallback,
          )
        ]
    );
  }
}