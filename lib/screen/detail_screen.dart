import 'package:flutter/material.dart';
import 'package:sda_hymnal/data/sda_hymnal.dart';

class HymnDetailScreen extends StatelessWidget {
  final SdaHymnal hymn;

  const HymnDetailScreen({super.key, required this.hymn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${hymn.number}. ${hymn.title}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: hymn.lyrics.map((lyric) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${lyric.type.substring(0, 1).toUpperCase()}${lyric.type.substring(1)} ${lyric.index}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 8.0),
                ...lyric.lines.map((line) => Text(line,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}