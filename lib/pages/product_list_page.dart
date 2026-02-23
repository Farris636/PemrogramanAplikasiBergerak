import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        id: '1',
        name: 'Laptop',
        price: 15000000,
        emoji: '💻',
        description: 'High performance laptop',
      ),
      Product(
        id: '2',
        name: 'Smartphone',
        price: 8000000,
        emoji: '📱',
        description: 'Flagship smartphone',
      ),
      Product(
        id: '3',
        name: 'Headphones',
        price: 1500000,
        emoji: '🎧',
        description: 'Noise cancelling',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      );
                    },
                  ),
                  if (cart.totalQuantity > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          cart.totalQuantity.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];

          return ListTile(
            leading: Text(product.emoji, style: const TextStyle(fontSize: 28)),
            title: Text(product.name),
            subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
            trailing: ElevatedButton(
              onPressed: () => context.read<CartModel>().addItem(product),
              child: const Text('Add'),
            ),
          );
        },
      ),
    );
  }
}
