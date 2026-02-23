import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, _) {
              return cart.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => cart.clear(),
                    );
            },
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, _) {
          if (cart.isEmpty) {
            return const Center(child: Text('Cart is Empty 🛒'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.itemsList.length,
                  itemBuilder: (_, index) {
                    final item = cart.itemsList[index];

                    return ListTile(
                      leading: Text(
                        item.product.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(item.product.name),
                      subtitle: Text(
                        'Rp ${(item.totalPrice).toStringAsFixed(0)}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () =>
                                cart.decreaseQuantity(item.product.id),
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () =>
                                cart.increaseQuantity(item.product.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Total: Rp ${cart.totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
