import 'package:flutter/material.dart';
import 'package:sda_hymnal/data/sda_hymnal.dart';

class HomeScreen extends StatelessWidget {
  final List<SdaHymnal> hymns;
  final ValueChanged<String> onTapped;

  const HomeScreen({
    super.key,
    required this.hymns,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDA Hymnal'),
      ),
      body: ListView.builder(
        itemCount: hymns.length,
        itemBuilder: (context, index) {
          final hymn = hymns[index];
          return ListTile(
            leading: Text(
              hymn.number.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(hymn.title),
            onTap: () => onTapped(hymn.index),
          );
        },
      ),
    );
  }
}