import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/providers/values_provider.dart';

class NewValueDialog extends StatefulWidget {
  NewValueDialog({
    @required this.onCreateNew,
  });

  final VoidCallback onCreateNew;

  @override
  _NewValueDialogState createState() => _NewValueDialogState();
}

class _NewValueDialogState extends State<NewValueDialog> {
  String _text;

  void createNewValue(String text) {
    if (text != null && text.isNotEmpty) {
      Provider.of<ValuesProvider>(context, listen: false).add(text: text);

      widget.onCreateNew();
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter a new value'),
      content: TextField(
        autofocus: true,
        onChanged: (value) => _text = value,
        onSubmitted: createNewValue,
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () => createNewValue(_text),
          child: Text('OK'),
        ),
      ],
    );
  }
}
