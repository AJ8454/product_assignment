import 'package:equatable/equatable.dart';
import 'package:product_assignment/models/product_model.dart';

class CartModel extends Equatable {
  const CartModel({this.products = const <Datum>[]});
  final List<Datum> products;

  double get totalValue =>
      products.fold(0, (total, current) => total + current.price!);

  String get total => totalValue.toStringAsFixed(2);

  // String get totalItemvalue => products.

  @override
  List<Object?> get props => [
    products
  ];
}
