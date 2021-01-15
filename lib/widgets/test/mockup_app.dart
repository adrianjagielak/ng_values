import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/value.dart';
import '../../services/providers/favorites_provider.dart';
import '../../services/providers/values_provider.dart';

/// Mockup app used for easier testing.
///
/// Contains MultiProvider with all of providers as well as MaterialApp widget.
class MockupApp extends StatelessWidget {
  MockupApp({
    this.values,
    this.favoritesIds,
    @required this.child,
  });

  final List<Value> values;
  final List<String> favoritesIds;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValuesProvider(values)),
        ChangeNotifierProvider(create: (_) => FavoritesProvider(favoritesIds)),
      ],
      builder: (_, __) => MaterialApp(home: child),
    );
  }
}
