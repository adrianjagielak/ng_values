import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/providers/values_provider.dart';
import '../widgets/database/database_list_item.dart';
import '../widgets/database/new_value_dialog.dart';

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ValuesProvider valuesProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        controller: scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: valuesProvider.values
                  .map((e) => DatabaseListItem(value: e))
                  .toList(),
            ),
          ),
          // Roughly the height of FloatingActionButton
          SizedBox(height: 64),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add new value'),
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => NewValueDialog(
            onCreateNew: () {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }
}
