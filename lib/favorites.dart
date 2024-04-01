import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );



    return Column(
      children: [
        Center(
          child: SafeArea(
              bottom: false,
              child: Text(
                  'Favorites',
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
