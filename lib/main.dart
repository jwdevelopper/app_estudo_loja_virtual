import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/auth.dart';
import 'package:gerencia_estado_provider/models/cart.dart';
import 'package:gerencia_estado_provider/models/order_list.dart';
import 'package:gerencia_estado_provider/models/product_list.dart';
import 'package:gerencia_estado_provider/pages/auth_or_home_page.dart';
import 'package:gerencia_estado_provider/pages/auth_page.dart';
import 'package:gerencia_estado_provider/pages/cart_page.dart';
import 'package:gerencia_estado_provider/pages/orders_page.dart';
import 'package:gerencia_estado_provider/pages/product_detail.page.dart';
import 'package:gerencia_estado_provider/pages/product_form_page.dart';
import 'package:gerencia_estado_provider/pages/product_overview.page.dart';
import 'package:gerencia_estado_provider/pages/product_page.dart';
import 'package:gerencia_estado_provider/utils/app.routes.dart';
import 'package:provider/provider.dart';

// https://shop-coder-7e821-default-rtdb.firebaseio.com/
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
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
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
            fontFamily: 'Lato'),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDERS: (context) => OrdersPage(),
          AppRoutes.PRODUCTS: (context) => ProductPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
        },
      ),
    );
  }
}
