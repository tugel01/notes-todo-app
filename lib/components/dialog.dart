import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/button.dart';

class MyDialog extends StatelessWidget {
  final TextEditingController myController;
  final Function() saveTask;

  const MyDialog({
    super.key,
    required this.myController,
    required this.saveTask,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 250),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'[\n\r]')),
                    ],

                    controller: myController,
                    decoration: InputDecoration(hintText: 'Add a new task'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    name: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                      myController.clear();
                    },
                  ),
                  const SizedBox(width: 20),
                  Button(name: 'Save', onPressed: saveTask),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
