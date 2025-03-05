import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  void _addToCart() async {
    try {
      await ApiService.addToCart("user123", widget.product['_id'], 1);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to Cart')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product['name'])),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.product['imageUrl'], width: double.infinity, height: 250, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("\$${widget.product['price']}", style: TextStyle(fontSize: 20, color: Colors.green)),
                SizedBox(height: 10),
                Text(widget.product['description']),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addToCart,
                  child: Text('Add to Cart'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
