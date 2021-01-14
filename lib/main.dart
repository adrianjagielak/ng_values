import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/value.dart';
import 'screens/home.dart';
import 'services/providers/favorites_provider.dart';
import 'services/providers/values_provider.dart';
import 'services/values_api.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValuesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        // we are using Builder because futures loading data from api and
        // storage needs to have provider instances above its contexts
        home: Builder(
          builder: (context) => FutureBuilder(
            future: Future.wait([
              _loadValues(context),
              _loadSavedFavorites(context),
            ]),
            builder: (context, snapshot) {
              Widget child;

              if (snapshot.connectionState == ConnectionState.waiting) {
                child = Container(
                  color: Colors.grey.shade100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                child = Home();
              }

              return AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Initial loading of all values from REST api and saved in device storage
Future _loadValues(BuildContext context) async {
  ValuesProvider valuesProvider = Provider.of(context, listen: false)
    ..clear()
    // Load Seven Core Values From Api
    ..setUp(await getCoreValues());

  // Load saved custom values

  SharedPreferences preferences = await SharedPreferences.getInstance();

  List<String> savedJsonValues =
      preferences.getStringList('custom_values') ?? [];

  List<Value> savedCustomValues =
      savedJsonValues.map((e) => Value.fromJson(jsonDecode(e)));

  valuesProvider.setUp(savedCustomValues);
}

/// Initial loading of saved favorites from device storage
Future _loadSavedFavorites(BuildContext context) async {
  FavoritesProvider favoritesProvider = Provider.of(context, listen: false)
    ..clear();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  // SharedPreferences only allow to save list of string so we will need to
  // parse them to ints
  List<String> ids = preferences.getStringList('favorites') ?? [];

  favoritesProvider.setUp(ids.map(int.parse));
}
