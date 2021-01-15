import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/value.dart';
import '../../services/providers/favorites_provider.dart';
import '../../services/providers/values_provider.dart';

class LovedListItem extends StatelessWidget {
  LovedListItem({
    @required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    ValuesProvider valuesProvider = Provider.of(context);

    Value value = valuesProvider.valueById(id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  value.text,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Unlove',
              icon: Icon(Icons.clear),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Warning!'),
                    content: Text(
                      'Are you sure you want to unlove this quote?',
                    ),
                    actions: [
                      FlatButton(
                        textColor: Theme.of(context).accentColor,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('CANCEL'),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).accentColor,
                        onPressed: () async {
                          await Provider.of<FavoritesProvider>(
                            context,
                            listen: false,
                          ).remove(value.id);

                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
