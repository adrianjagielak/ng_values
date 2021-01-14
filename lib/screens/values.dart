import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/providers/values_provider.dart';

class Values extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValuesProvider valuesProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Netguru Values'),
      ),
      body: Center(
        child: Text(valuesProvider.values.first.text),
      ),
    );
  }
}
