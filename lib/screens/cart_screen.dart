import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/blocs/cart/cart_bloc.dart';
import 'package:interview_project/blocs/cart/cart_event.dart';
import 'package:interview_project/blocs/cart/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text("Cart is Empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final diamond = state.items[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(

                        trailing: IconButton(
                          icon: const Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(RemoveFromCart(diamond));
                          },
                        ),

                      title: Text("Diamond #${diamond.lotId} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Carat: ${diamond.carat} | Color: ${diamond.color} | Clarity: ${diamond.clarity}"),
                          Text("Lab: ${diamond.lab} | Color: ${diamond.shape}"),
                          Text("FinalAmount: ${diamond.finalAmount.toStringAsFixed(2)}",style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Text(
                    //   "Total: \$${state.totalPrice.toStringAsFixed(2)}",
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(ClearCart());
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text("Clear Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
