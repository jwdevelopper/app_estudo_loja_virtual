import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/cart.dart';
import 'package:gerencia_estado_provider/models/order_list.dart';
import 'package:gerencia_estado_provider/models/product_list.dart';
import 'package:gerencia_estado_provider/pages/cart_page.dart';
import 'package:gerencia_estado_provider/pages/orders_page.dart';
import 'package:gerencia_estado_provider/pages/product_detail.page.dart';
import 'package:gerencia_estado_provider/pages/product_overview.page.dart';
import 'package:gerencia_estado_provider/utils/app.routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList()
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            tertiary: Colors.tealAccent),
          fontFamily: 'Lato'
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (context) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDERS: (context) => OrdersPage(),
        },
      ),
    );
  }
}

