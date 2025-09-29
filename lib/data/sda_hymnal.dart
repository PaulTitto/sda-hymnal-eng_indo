
import 'dart:convert';

import 'package:flutter/services.dart';

class SdaHymnal {
  final String index;
  final int number;
  final String title;
  final List<Lyric> lyrics;

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
      lyrics: (json["lyrics"] as List<dynamic>)
      .map((lyricJson) => Lyric.fromJson(lyricJson as Map<String, dynamic>)).toList()
  );

  static SdaHymnal? findById(List<SdaHymnal> hymns, String id){
    try{
      return hymns.firstWhere((hymns)=> hymns.index == id);
  }catch(e){
      return null;
  }
  }
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


Future<List<SdaHymnal>> loadHymns() async {
  final String jsonData = await rootBundle.loadString('assets/hymnal/sda-hymnal-db-eng.json');
  final List<dynamic> parsedJson = jsonDecode(jsonData) as List<dynamic>;

  return parsedJson
      .map((hymnJson) => SdaHymnal.fromJson(hymnJson as Map<String, dynamic>))
      .toList();
}
