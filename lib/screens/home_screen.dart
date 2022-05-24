import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_assignment/bloc/cart_bloc/cart_bloc.dart';
import 'package:product_assignment/bloc/product_bloc/product_bloc.dart';
import 'package:product_assignment/models/product_model.dart';
import 'package:product_assignment/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    this.allProducts,
  }) : super(key: key);

  List<Datum>? allProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Mall'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CartScreen(),
            )),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductErrorState) {
          return Center(
            child: Text(state.message!),
          );
        }
        if (state is ProductLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoadedState) {
          allProducts = state.products.cast<Datum>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: allProducts!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.white,
                      leading: SizedBox(
                        width: 60,
                        child: Text(
                          allProducts![index].title!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          if (state is CartLoadedState) {
                            return IconButton(
                              onPressed: () {
                                const snackBar = SnackBar(
                                  content: Text('Added to your cart'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                context.read<CartBloc>().add(AddCartProduct(
                                    product: allProducts![index]));
                              },
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Colors.grey,
                                size: 18,
                              ),
                            );
                          } else {
                            return const Text('Something is wrong');
                          }
                        },
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(allProducts![index].featuredImage!),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      }),
    );
  }
}
