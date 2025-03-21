import 'package:equatable/equatable.dart';
import 'package:interview_project/models/diamond.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}


class AddToCart extends CartEvent {
  final Diamond diamond;

  const AddToCart(this.diamond);

  @override
  List<Object> get props => [diamond];
}

class RemoveFromCart extends CartEvent {
  final Diamond diamond;

  const RemoveFromCart(this.diamond);

  @override
  List<Object> get props => [diamond];
}

class ClearCart extends CartEvent {}
