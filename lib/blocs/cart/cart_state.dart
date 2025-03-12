import 'package:equatable/equatable.dart';
import 'package:interview_project/models/diamond.dart';

class CartState extends Equatable {
  final List<Diamond> items;

  const CartState({
    this.items = const [],
  });

  double get totalPrice => items.fold(0, (sum, item) => sum + item.finalAmount);

  CartState copyWith({
    List<Diamond>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}