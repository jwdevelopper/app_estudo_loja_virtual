import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/components/product_grid_item.component.dart';
import 'package:gerencia_estado_provider/models/product.dart';
import 'package:gerencia_estado_provider/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  ProductGrid({required this.showFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
        value:  loadedProducts[i],
        child: ProductGridItem()
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
    );
  }
}