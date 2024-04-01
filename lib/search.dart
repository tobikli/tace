import 'appState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final style2 = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = MyAppState();


    return Column(
      children: [
        Center(
          child: SafeArea(
              bottom: false,
              child: Text(
                  'Search',
                  style: style1)),
        ),
        Expanded(
          child: ListView(
            children: [
              Text('test'),
            ],
          ),
        ),
      ],
    );
  }
}

