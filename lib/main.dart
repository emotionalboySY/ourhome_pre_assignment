import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhome_pre_assignment/controllers/shopping_bag.dart';
import 'package:ourhome_pre_assignment/pages/product_list.dart';
import 'package:ourhome_pre_assignment/routes.dart';

import 'controllers/product_list.dart';

void main() {
  Get.put(ShoppingBagController());
  Get.put(ProductListController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ourhome Pre-Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            background: Colors.white,
          ),
          fontFamily: "Pretendard",
          useMaterial3: true,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
              overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
              elevation: MaterialStateProperty.resolveWith((states) => 0.0),
              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
              minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent,
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent,
              ),
              elevation: MaterialStateProperty.resolveWith(
                    (states) => 0.0,
              ),
              minimumSize: MaterialStateProperty.resolveWith(
                    (states) => Size.zero,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.resolveWith(
                    (states) => EdgeInsets.zero,
              ),
            )
          )
        ),
        home: const Home(),
        getPages: route,
        defaultTransition: Transition.noTransition,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductListPageBuilder();
  }
}
