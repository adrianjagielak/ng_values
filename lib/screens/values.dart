import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../models/value.dart';
import '../services/extensions.dart';
import '../services/providers/favorites_provider.dart';
import '../services/providers/values_provider.dart';

class Values extends StatefulWidget {
  Values({Key key}) : super(key: key);

  @override
  _ValuesState createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
  /// Main Values stream.
  StreamController<Value> streamController = StreamController<Value>();

  /// Timer that is used for adding random values to stream.
  Timer timer;

  /// We are using recurrent timer instead just of periodic Stream or Timer to
  /// properly implement refresh button. With normal periodic stream/timer ifł
  /// user clicks refresh button right before new value is added to main Stream
  /// there will be two new values displayed in very short time. With recurrent
  /// timers we can always reset 5-seconds period after each `refresh` click
  /// canceling and making new timer.
  Timer newTimer() => Timer(Duration(seconds: 5), refreshTimer);

  void refreshTimer() {
    // Take new fonts from list

    // Get font from cycled list.
    _textStyleNow = fonts[_textStyleIterator++ % fonts.length].copyWith(
      // Material Design Headline 5
      fontSize: 24,
    );

    // Get the next font from cycled list.
    _textStyleNext = fonts[(_textStyleIterator + 1) % fonts.length].copyWith(
      fontSize: 0,
    );

    // Take new value from list

    ValuesProvider valuesProvider = Provider.of(context, listen: false);

    Value newValue = valuesProvider.values
        // Do not show the same Value twice.
        .where((e) => e.id != _previousValue.id)
        .toList()
        .random;

    streamController.add(newValue);

    _previousValue = newValue;

    timer = newTimer();
  }

  /// Previous value used to not show the same Value twice.
  Value _previousValue = Value(id: 'theFirstValue', text: 'MustBeNonExistent');

  /// TextStyle to be used on main Value widget.
  TextStyle _textStyleNow = fonts[2];

  /// TextStyle that is going to be used next.
  ///
  /// Used for pre-caching the font from Google Fonts.
  TextStyle _textStyleNext = fonts[3];

  /// TextStyle list iterator.
  int _textStyleIterator = 0;

  @override
  void initState() {
    super.initState();

    refreshTimer();
  }

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider = Provider.of(context);

    return StreamBuilder<Value>(
      stream: streamController.stream,
      builder: (context, snapshot) {
        // We get data from this stream near instantaneous so we can ignore
        // initial delay for now.
        if (!snapshot.hasData) {
          return Container();
        }

        Value value = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text('Netguru Values'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    transitionBuilder: animations.random,
                    child: Text(
                      value.text,
                      key: ValueKey(value.text),
                      textAlign: TextAlign.center,
                      style: _textStyleNow,
                    ),
                  ),
                ),
              ),
              // Pre-cache a next font from the list.
              Text('', style: _textStyleNext),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  timer.cancel();

                  refreshTimer();
                },
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
              SizedBox(height: 16),
              if (favoritesProvider.favoritesIds.contains(value.id))
                FloatingActionButton.extended(
                  key: ValueKey<String>('Remove from favorites fab'),
                  onPressed: () async => favoritesProvider.remove(value.id),
                  label: Text('Remove from favorites'),
                  icon: Icon(MdiIcons.heartBroken),
                )
              else
                FloatingActionButton.extended(
                  key: ValueKey<String>('Add to favorites fab'),
                  onPressed: () async => favoritesProvider.add(value.id),
                  label: Text('Add to favorites'),
                  icon: Icon(Icons.favorite_outline),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    streamController.close();

    super.dispose();
  }
}

/// List of fonts used in the main Value widget.
List<TextStyle> get fonts => [
      GoogleFonts.robotoMono(),
      GoogleFonts.merriweather(),
      GoogleFonts.libreBaskerville(),
      GoogleFonts.lato(),
    ];

/// List of animations used in the main Value widget.
List<AnimatedSwitcherTransitionBuilder> get animations => [
      (child, animation) => SlideTransition(
            position: Tween<Offset>(
              // X cannot be 0 because X=0 & Y=(-1|1) looks bad.
              begin: Offset([-1.0, 1.0].random, [-1.0, 0.0, 1.0].random),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
      (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
      (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
    ];
