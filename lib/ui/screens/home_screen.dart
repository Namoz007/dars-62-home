import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:provider/provider.dart';
import '../../controller/product_controller.dart';
import '../../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _descController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _product = context.read<ProductController>();
    return Scaffold(
      body: Query(
        options: _product.get(),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          } else if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List products = result.data!['products'];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final Product product = Product.fromMap(products[index]);
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _titleController.text = product.title;
                          _descController.text = product.description;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(product.title),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _titleController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "New Title..."),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: _descController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "New Subtitle..."),
                                    )
                                  ],
                                ),
                                actions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                  FilledButton(
                                      onPressed: () async {
                                        await _product.update(Product(
                                          id: product.id,
                                          title: _titleController.text,
                                          price: product.price,
                                          description: _descController.text,
                                          category: product.category,
                                        ));
                                        refetch!();
                                        print(product.title);
                                        Navigator.of(context).pop();
                                        _titleController.clear();
                                        _descController.clear();
                                      },
                                      child: const Text("Save"))
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _product.delete(product.id);
                          refetch!();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createProduct(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createProduct(BuildContext context) async {
    final _product = context.read<ProductController>();

    await _product.add(Product(
      id: 'id',
      title: "Test",
      price: 12.0,
      description: "Welcome to Najot ta'lim",
      category: {"name": "Anvar"},
    ));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Product created")));
  }
}
