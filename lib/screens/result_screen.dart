import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/blocs/cart/cart_bloc.dart';
import 'package:interview_project/blocs/cart/cart_event.dart';
import 'package:interview_project/blocs/cart/cart_state.dart';
import 'package:interview_project/blocs/filter/filter_bloc.dart';
import 'package:interview_project/blocs/filter/filter_state.dart';

import 'cart_screen.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtered Diamonds"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Visibility(
                visible: state.items.isNotEmpty,
                child: Text(
                  '${state.items.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filtered Results", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  if (state is FilterLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FilterError) {
                    return Center(child: Text(state.message));
                  } else if (state is FilterSuccess) {
                    return ListView.builder(
                      itemCount: state.diamonds.length,
                      itemBuilder: (context, index) {
                        final diamond = state.diamonds[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
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
                            trailing: BlocBuilder<CartBloc, CartState>(
                              builder: (context, cartState) {
                                final isInCart = cartState.items.any((item) => item.lotId == diamond.lotId);
                                return Checkbox(
                                  value: isInCart,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      BlocProvider.of<CartBloc>(context).add(AddToCart(diamond));
                                    } else {
                                      BlocProvider.of<CartBloc>(context).add(RemoveFromCart(diamond));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("No results found"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
