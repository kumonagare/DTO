import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../ads/banner_ad_widget.dart';
import '../play_screen/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreen createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  int selectedValue = 1;
  List<int> lists = List.generate(9, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(411, 683),
        builder: (BuildContext context, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: (context.height -
                    (context.safePaddingTop + context.safePaddingBottom)) *
                0.1,
            title: const Text('トランプで順番決め'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.2,
                  width: context.width * 0.7,
                  margin: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '◇ルール◇\n数が大きいカードを\n出した人の勝ち',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.1,
                  alignment: Alignment.center,
                  child: Text(
                    'プレイ人数',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.1,
                  alignment: Alignment.center,
                  child: DropdownButton<int>(
                    value: selectedValue,
                    items: lists.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Container(
                          height: (context.height -
                                  (context.safePaddingTop +
                                      context.safePaddingBottom)) *
                              0.1,
                          alignment: Alignment.center,
                          child: Text(
                            value.toString(),
                            style: TextStyle(fontSize: 32.0.sp),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  height: (context.height -
                          (context.safePaddingTop +
                              context.safePaddingBottom)) *
                      0.3,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () => GoRouter.of(context).push('/second/$selectedValue'),
                    child: Container(
                      height: (context.height -
                              (context.safePaddingTop +
                                  context.safePaddingBottom)) *
                          0.1,
                      width: context.width * 0.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.red[300]!,
                            Colors.red[500]!,
                            Colors.red[700]!,
                          ],
                        ),
                      ),
                      child: Text(
                        'スタート',
                        style: TextStyle(
                          fontSize: 27.sp,
                        ),
                      ),
                    ),
                  ),
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
