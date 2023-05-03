import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/product.dart';
import 'package:gerencia_estado_provider/providers/counter_provider.dart';


class CounterPage extends StatefulWidget {
  
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exemplo contador'),
      ),
      body: Column(children: [
        Text(CounterProvider.of(context)?.state.value.toString() ??'0'),
        IconButton(onPressed: (){
          setState(() {
            CounterProvider.of(context)?.state.inc();  
          });
          
          print(CounterProvider.of(context)?.state.value);
        }, icon: Icon(Icons.add)),
        IconButton(onPressed: (){
          setState(() {
            CounterProvider.of(context)?.state.dec();  
          });
          print(CounterProvider.of(context)?.state.value);
        }, icon: Icon(Icons.remove))
      ]),
    );
  }
}