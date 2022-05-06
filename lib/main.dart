import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/helper/route_helper.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'route_generator.dart';
import 'package:sizer/sizer.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    //Register Providers
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NewsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RouteHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, d) {
        return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
          builder: BotToastInit(),
          debugShowCheckedModeBanner: false,
          title: 'News App',
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: MyApp.navigatorKey,
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ],
        );
      },
    );
  }
}
