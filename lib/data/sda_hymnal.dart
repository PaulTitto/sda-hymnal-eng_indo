
import 'dart:convert';

import 'package:flutter/services.dart';

class SdaHymnal {
  final String index;
  final int number;
  final String title;
  final Lyric lyrics;

  SdaHymnal({
    required this.index,
    required this.number,
    required this.title,
    required this.lyrics,
  });

  factory SdaHymnal.fromJson(Map<String, dynamic> json) => SdaHymnal(
      index: json["index"] as String,
      number: json["number"] as int,
      title: json["title"] as String,
      lyrics: Lyric.fromJson(json["lyrics"])
  );
}



class Lyric{
  final String type;
  final int index;
  final List<String> lines;

  Lyric({
    required this.type,
    required this.index,
    required this.lines,
});

  factory Lyric.fromJson(Map<String, dynamic> json) => Lyric (
    type: json["type"] as String,
    index: json["index"] as int,
    lines: List<String>.from(json["lines"].map((x) => x as String)),
  );
}


Future<Map<String, dynamic>> loadHymnData() async {
  final String jsonData = await rootBundle.loadString('assets/sda_hymnal.json');
  final Map<String, dynamic> parsedJson = jsonDecode(jsonData);
  return parsedJson;
}
