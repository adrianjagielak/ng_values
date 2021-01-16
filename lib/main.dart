import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'services/providers/favorites_provider.dart';
import 'services/providers/values_provider.dart';
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
              loadValues(context),
              loadSavedFavorites(context),
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
