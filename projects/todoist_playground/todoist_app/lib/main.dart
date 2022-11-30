import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:todoist_app/core/provider/user_profile_provider.dart';
import 'package:todoist_app/constants/router_name_constants.dart';
import 'package:todoist_app/core/provider/service_provider.dart';
import 'package:todoist_app/core/provider/theme_change_provider.dart';
import 'package:todoist_app/core/provider/validation_provider.dart';
import 'package:todoist_app/core/themes/themes_change.dart';
import 'package:todoist_app/router/router.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeChangeProvider appModel = ThemeChangeProvider();

  @override
  void initState() {
    super.initState();
    _initAppTheme();
  }

  void _initAppTheme() async {
    appModel.darkTheme = await appModel.appPreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ServiceProvider()),
          ChangeNotifierProvider(create: (_) => FormProvider()),
          ChangeNotifierProvider(create: (_) => ThemeChangeProvider()),
          ChangeNotifierProvider(create: (_) => UserProfilePrefProvider()),
        ],
        child: Consumer<ThemeChangeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Todoist App',
              theme: value.darkTheme ? CustomTheme.buildDarkTheme() : CustomTheme.buildLightTheme(),
              initialRoute: splashRoute,
              onGenerateRoute: CustomRouter.generateRoute,
            );
          },
        ));
  }
}
