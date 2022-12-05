import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:woby/feature/collection/collections_screen.dart';

class LearnScreen extends StatelessWidget {
  final CollectionData collectionData;
  const LearnScreen({required this.collectionData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(collectionData.name),
          centerTitle: true,
        ),
        body: WordCardSimpleWidget(
          wordData: collectionData.words[0],
          height: _height,
        ),
      ),
    );
  }
}

class WordCardSimpleWidget extends StatelessWidget {
  const WordCardSimpleWidget({required this.wordData, required this.height, Key? key})
      : super(key: key);
  final WordData wordData;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double point = height / 8;
    final wordSize = point * 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            wordData.dictionaryData.word,
            style: TextStyle(fontSize: wordSize),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('[${wordData.dictionaryData.text}]'),
            IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.mic_rounded)),
        const Spacer(),
        Text('correct'.tr())
      ],
    );
  }
}
