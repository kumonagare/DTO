import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ads/banner_ad_widget.dart';
import '../animation/animation.dart';
import '../data/data.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  late List<CardData> availableImages;

  int value = 0;
  int totalCount = 0;
  int selectedValue = 0;
  List<CardData> drawnCards = [];
  List<String> rankings = [];

  @override
  void initState() {
    super.initState();
    availableImages = [...cards]..shuffle();
  }

  void incrementCount(value) {
    print('incrementCount called');
    drawnCards.add(availableImages[value]);
    totalCount++;
    if (totalCount == selectedValue) {
      final List<CardData> uniqueCards = drawnCards.toSet().toList();
      final List<CardData> sortedCards = List.from(uniqueCards)
        ..sort((a, b) => b.value.compareTo(a.value));

      rankings.clear();

      for (int i = 0; i < totalCount; i++) {
        rankings.add('${i + 1}番目：${sortedCards[i].name}');
        print('Rankings: $rankings');
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start, // ダイアログを画面の上部に配置
              children: [
                AlertDialog(
                  title: const Text('順番'),
                  content: Container(
                    height: 50, // 高さを210に設定
                    width: context.width * 0.8,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              rankings.map((ranking) => Text(ranking)).toList(),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final getData = ModalRoute.of(context)
        ?.settings
        .arguments
        .toString(); // first_screenから値を取得
    if (getData != null && getData.isNotEmpty) {
      selectedValue = int.parse(getData[getData.length - 2]); // 文字列の最後から2番目を取得
    }
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(411, 683),
        builder: (BuildContext context, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: (context.height -
                    (context.safePaddingTop + context.safePaddingBottom)) *
                0.1,
            title: const Text('Back'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.15,
                  width: context.width * 0.7,
                  margin: EdgeInsets.all(
                    (context.height -
                            (context.safePaddingTop +
                                context.safePaddingBottom)) *
                        0.03,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(context.width * 0.8, context.height * 0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('結果',style: TextStyle(fontSize: 30),),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start, // ダイアログを画面の上部に配置
                            children: [
                              AlertDialog(
                                title: const Text('順番'),
                                content: Container(
                                  height: 90, // 高さを210に設定
                                  width: context.width * 0.8,
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: rankings
                                            .map((ranking) => Text(ranking))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (j) {
                        value = i * 3 + j;
                        return Container(
                          height: (context.height -
                                  (context.safePaddingTop +
                                      context.safePaddingBottom)) *
                              0.15,
                          margin: EdgeInsets.all((context.height -
                                  (context.safePaddingTop +
                                      context.safePaddingBottom)) *
                              0.01),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: AnimationCard(
                            value: value,
                            frontImage: Image.asset(
                                availableImages[i * 3 + j].imagePath),
                            incrementCallback: incrementCount,
                          ),
                        );
                      }),
                    );
                  }),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.1,
                  child: const BannerAdWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get safePaddingTop => MediaQuery.of(this).padding.top;
  double get safePaddingBottom => MediaQuery.of(this).padding.bottom;
}
