import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(product.emoji, style: const TextStyle(fontSize: 28)),
      title: Text(product.name),
      subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
      trailing: ElevatedButton(
        onPressed: () => context.read<CartModel>().addItem(product),
        child: const Text('Add'),
      ),
    );
  }
}
