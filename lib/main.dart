import 'package:assignemnt/cart_screen/cart_screen_view.dart';
import 'package:assignemnt/cart_screen/cart_screen_vm.dart';
import 'package:assignemnt/home_screen/home_screen_vm.dart';
import 'package:assignemnt/product_details_screen/product_detail_vm.dart';
import 'package:assignemnt/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen/home_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));

    // SharedPreferences.setMockInitialValues({});

    return MultiProvider(
      providers: [
        //Home Screen
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        //Product detail Screen
        ChangeNotifierProvider(
          create: (context) => ProductDetailViewMoidel(),
        ),
        //Cart Screen
        ChangeNotifierProvider(
          create: (context) => CartScreenViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashView(),
      ),
    );
  }
}
