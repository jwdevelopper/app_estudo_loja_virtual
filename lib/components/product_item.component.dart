import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/cart.dart';
import 'package:gerencia_estado_provider/models/product.dart';
import 'package:gerencia_estado_provider/pages/product_detail.page.dart';
import 'package:gerencia_estado_provider/utils/app.routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (ctx) => ProductDetailPage(product: product),
            // ));
            Navigator.of(context).pushNamed(AppRoutes.PRODUCT_DETAIL,arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            //o ultimo parametro se trata do child vc pode passar usando o atributo de child acima de builder
            //e com isso esse child sera imutavel
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              print(cart.itemsCount);
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
