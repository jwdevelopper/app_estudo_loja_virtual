import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/components/app_drawer.dart';
import 'package:gerencia_estado_provider/components/order_widget.dart';
import 'package:gerencia_estado_provider/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<OrderList>(
               builder: (ctx,orders,child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
              ),
            );
          }
        },
      ),
      // body: _isLoading ? Center(
      //   child: CircularProgressIndicator(),
      // ) : ListView.builder(
      //   itemCount: orders.itemsCount,
      //   itemBuilder: (ctx, i) => OrderWidget(order:orders.items[i]),
      // ),
    );
  }
}
