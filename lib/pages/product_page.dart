import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/components/app_drawer.dart';
import 'package:gerencia_estado_provider/components/product_item.dart';
import 'package:gerencia_estado_provider/models/product_list.dart';
import 'package:gerencia_estado_provider/utils/app.routes.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(
                product: products.items[i],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
