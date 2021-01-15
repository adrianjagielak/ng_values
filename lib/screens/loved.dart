import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/providers/favorites_provider.dart';
import '../widgets/loved/loved_list_item.dart';

class Loved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Loved'),
      ),
      body: favoritesProvider.favoritesIds.isEmpty
          ? Center(
              child: Text('Love something and it will be displayed here :)'),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: favoritesProvider.favoritesIds
                      .map((e) => LovedListItem(id: e))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
