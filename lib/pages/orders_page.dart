

import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/components/app_drawer.dart';
import 'package:gerencia_estado_provider/components/order_widget.dart';
import 'package:gerencia_estado_provider/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order:orders.items[i]),
      ),
    );
  }
}