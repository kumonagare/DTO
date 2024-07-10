import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'ads/ads_controller.dart';
import 'app_lifecycle/app_lifecycle.dart';
import 'play_screen/first_screen.dart';
import 'play_screen/second_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  AdsController? adsController;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    adsController = AdsController(MobileAds.instance);
    adsController.initialize();
  }

  runApp(MyApp(
    adsController: adsController,
  ));
}

Logger _log = Logger('main.dart');

class MyApp extends StatelessWidget {
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const FirstScreen(key: Key('first screen')),
        routes: [
          GoRoute(
            path: 'second/:selectedValue',
            builder: (context, state) => const SecondScreen(
              key: Key('second screen'),
            ),
          ),
        ],
      ),
    ],
  );

  final AdsController? adsController;

  const MyApp({
    required this.adsController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider<AdsController?>.value(value: adsController),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'トランプで順番決め',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
          );
        }),
      ),
    );
  }
}
