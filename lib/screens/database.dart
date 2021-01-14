import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/providers/values_provider.dart';
import '../widgets/database_list_item.dart';

class Database extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValuesProvider valuesProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: ListView(
        children: valuesProvider.values
            .map((e) => DatabaseListItem(value: e))
            .toList(),
      ),
    );
  }
}
