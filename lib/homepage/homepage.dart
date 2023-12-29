import 'package:appstree/homepage/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/productprovider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    productProvider.fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppStree'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 50,
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  final products = productProvider.products;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isSelected =
                          productProvider.isSelected(product.title);

                      return GestureDetector(
                        onTap: () {
                          productProvider.toggleProductSelection(product.title);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected == true
                                  ? Colors.blue
                                  : Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            product.title,
                            style: TextStyle(
                              color: isSelected == true
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                final products = productProvider.products;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: product),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              product.thumbnail,
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              product.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Price: \$${product.price.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
