import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/blocs/cart/cart_event.dart';
import 'package:interview_project/blocs/cart/cart_state.dart';
import 'package:interview_project/models/diamond.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) async{
    final updatedItems = List<Diamond>.from(state.items)..add(event.diamond);
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    await prefs.setString('cart_items', updatedItems.toString());
    emit(state.copyWith(items: updatedItems));
  }


  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = List<Diamond>.from(state.items)
      ..removeWhere((diamond) => diamond.lotId == event.diamond.lotId);
    emit(state.copyWith(items: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}