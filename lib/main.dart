import 'package:fintech_dashboard_clone/Controller/DataController.dart';
import 'package:fintech_dashboard_clone/Controller/LoginController.dart';
import 'package:fintech_dashboard_clone/Controller/NavigationHandler.dart';
import 'package:fintech_dashboard_clone/layout/app_layout.dart';
import 'package:fintech_dashboard_clone/widgets/Auth/ProfileScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fintech_dashboard_clone/sections/latest_transactions.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:fintech_dashboard_clone/widgets/Auth/LoginScreen.dart';
import 'package:fintech_dashboard_clone/widgets/HomeWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'widgets/Setting/SettingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await Get.putAsync(() => DbService().init());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDkh3jLXNQ3B3Lzph3ZtHXr2cv_lUbCjW8",
          authDomain: "mindboost-88a41.firebaseapp.com",
          projectId: "mindboost-88a41",
          storageBucket: "mindboost-88a41.appspot.com",
          messagingSenderId: "1083853009965",
          appId: "1:1083853009965:web:1b08e7da9fec109a48f4a4",
          measurementId: "G-9BP6Y7XGCX"));
  initLoading();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DataHandlerController(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => NavigationHandler(),
    )
  ], child: const FintechDasboardApp()));
}

initLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class FintechDasboardApp extends StatefulWidget {
  const FintechDasboardApp({Key? key}) : super(key: key);

  @override
  State<FintechDasboardApp> createState() => _FintechDasboardAppState();
}

class _FintechDasboardAppState extends State<FintechDasboardApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginController>(context, listen: false).checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
        scrollbarTheme: Styles.scrollbarTheme,
      ),
      home:
          Consumer<LoginController>(builder: (context, loginController, child) {
        return loginController.loggedInUser == null
            ? const LoginScreen()
            : const HomePage();
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NavigationHandler>(
            builder: (context, navigationHandler, child) {
          return AppLayout(
              content: navigationHandler.selectedIndex == 0
                  ? const HomeWidget()
                  : navigationHandler.selectedIndex == 1
                      ? const LatestTransactions()
                      : navigationHandler.selectedIndex == 2
                          ? const SettingScreen()
                          : const ProfileScreen());
        }),
      ),
    );
  }
}

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }
}
