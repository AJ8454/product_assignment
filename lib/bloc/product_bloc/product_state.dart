part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String? message;
  const ProductErrorState({this.message});
}

class ProductLoadedState extends ProductState {
  final List<Datum> products;
  const ProductLoadedState(this.products);
}
