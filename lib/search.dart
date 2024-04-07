import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
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
                  'Search',
                  style: style1)),
        ),
        SizedBox(height: 50),
        Text("Coming Soon")
      ],
    );
  }
}

