import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import '../widgets/cart_badge.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_filter.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final products = [
    Product(
      id: '1',
      name: 'Laptop Gaming',
      price: 15000000,
      emoji: '💻',
      description: 'High performance',
      category: 'Electronics',
    ),
    Product(
      id: '2',
      name: 'Headphones',
      price: 1500000,
      emoji: '🎧',
      description: 'Noise cancelling',
      category: 'Accessories',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Electronics', 'Accessories'];

    final filteredProducts = products.where((product) {
      final matchSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchCategory =
          selectedCategory == 'All' || product.category == selectedCategory;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [CartBadge()],
      ),
      body: Column(
        children: [
          SearchBarWidget(
            onChanged: (value) {
              setState(() => searchQuery = value);
            },
          ),
          CategoryFilter(
            categories: categories,
            selected: selectedCategory,
            onSelected: (value) {
              setState(() => selectedCategory = value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) =>
                  ProductTile(product: filteredProducts[index]),
            ),
          ),
        ],
      ),
    );
  }
}
