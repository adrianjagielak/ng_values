import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/value.dart';
import '../../services/providers/favorites_provider.dart';
import '../../services/providers/values_provider.dart';

class DatabaseListItem extends StatelessWidget {
  DatabaseListItem({
    @required this.value,
  });

  final Value value;

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider = Provider.of(context);

    bool isFavorite = favoritesProvider.favoritesIds.contains(value.id);

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
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => isFavorite
                  ? favoritesProvider.remove(value.id)
                  : favoritesProvider.add(value.id),
            ),
            if (value.canBeDeleted)
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Warning!'),
                      content: Text(
                        'Are you sure you want to erase this precious quote '
                        'from history?',
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('CANCEL'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Provider.of<ValuesProvider>(context, listen: false)
                                .remove(value.id);

                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                ),
              )
            else
              SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
