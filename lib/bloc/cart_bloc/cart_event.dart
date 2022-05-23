part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class Loadcart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddCartProduct extends CartEvent {
  final Datum? product;
  const AddCartProduct({this.product});

  @override
  List<Object> get props => [];
}

class RemovedCartProduct extends CartEvent {
  final Datum? product;
  const RemovedCartProduct({this.product});

  @override
  List<Object> get props => [];
}
