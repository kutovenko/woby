import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:woby/feature/collection/collections_screen.dart';

class LearnScreen extends StatelessWidget {
  final CollectionData collectionData;
  const LearnScreen({required this.collectionData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(collectionData.name),
          centerTitle: true,
        ),
        body: WordCardSimpleWidget(
          wordData: collectionData.words[0],
          height: height,
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
    return SizedBox(
      height: height,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                iconSize: point,
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_left_rounded,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      wordData.dictionaryData.word,
                      style: TextStyle(fontSize: point / 2),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('[${wordData.dictionaryData.text}]'),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  IconButton(
                      iconSize: point,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic_rounded,
                      )),
                  Text('correct'.tr()),
                  const SizedBox(
                    height: 24.0,
                  )
                ],
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(32.0),
            //       child: Text(
            //         wordData.dictionaryData.word,
            //         style: TextStyle(fontSize: point),
            //       ),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text('[${wordData.dictionaryData.text}]'),
            //         IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 24.0,
            //     ),
            //     IconButton(
            //         iconSize: point,
            //         onPressed: () {},
            //         icon: const Icon(
            //           Icons.mic_rounded,
            //         )),
            //     const Spacer(),
            //     Text('correct'.tr()),
            //     const SizedBox(
            //       height: 24.0,
            //     )
            //   ],
            // ),
            IconButton(
                iconSize: point,
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right_rounded,
                ))
          ],
        ),
      ),
    );
  }
}
