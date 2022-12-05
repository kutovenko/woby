import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:woby/feature/learn/learn_screen.dart';

class CollectionsScreen extends StatelessWidget {
  CollectionsScreen({Key? key}) : super(key: key);

  final List<CollectionData> collections = [
    CollectionData(
        name: 'Flowers',
        description: '',
        words: [
          WordData(
              wordStats: WordStats(stats: {'difficulty': 1}),
              dictionaryData: DictionaryData(word: 'Rose', text: '[rose]', audioUrl: 'url'))
        ],
        stats: CollectionStats(stats: {'level': 1.0})),
    CollectionData(
        name: 'Animals',
        description: '',
        words: [
          WordData(
              wordStats: WordStats(stats: {'difficulty': 5}),
              dictionaryData: DictionaryData(word: 'Cat', text: '[cat]', audioUrl: 'url'))
        ],
        stats: CollectionStats(stats: {'level': 1.0})),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(children: [
          Text('collections'.tr()),
          CollectionCardWidget(collectionData: collections[0]),
          CollectionCardWidget(collectionData: collections[1])
        ]),
      ),
    );
  }
}

class CollectionCardWidget extends StatelessWidget {
  const CollectionCardWidget({required this.collectionData, Key? key}) : super(key: key);
  final CollectionData collectionData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => LearnScreen(collectionData: collectionData))),
      child: Card(
        elevation: 2.0,
        color: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(collectionData.name),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text('${'total_words'.tr()}: ${collectionData.words.length.toString()}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollectionData {
  final String name;
  final String description;
  final List<WordData> words;
  final CollectionStats stats;

  String get difficulty => _getDifficulty();
  int get difficultyMin => _getMin();
  int get difficultyMax => _getMax();

  CollectionData(
      {required this.name, required this.description, required this.words, required this.stats});

  String _getDifficulty() {
    final values = words.map((e) => e.wordStats.stats['difficulty']!.toInt()).toList();
    return '${values.reduce(min)}...${values.reduce(max)}';
  }

  int _getMin() {
    return words.map((e) => e.wordStats.stats['difficulty']!.toInt()).toList().reduce(min);
  }

  int _getMax() {
    return words.map((e) => e.wordStats.stats['difficulty']!.toInt()).toList().reduce(max);
  }
}

class CollectionStats {
  final Map<String, double> stats;

  CollectionStats({required this.stats});
}

class WordData {
  WordStats wordStats;
  DictionaryData dictionaryData;

  WordData({required this.wordStats, required this.dictionaryData});
}

class DictionaryData {
  String word;
  String audioUrl;
  String text;

  DictionaryData({required this.word, required this.text, required this.audioUrl});

  DictionaryData.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        text = json['phonetics']['text'],
        audioUrl = json['phonetics']['audio'];
}

class WordStats {
  final Map<String, double> stats;

  WordStats({required this.stats});
}
