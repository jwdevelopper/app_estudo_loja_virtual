import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/auth.dart';
import 'package:gerencia_estado_provider/pages/auth_page.dart';
import 'package:gerencia_estado_provider/pages/product_overview.page.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}