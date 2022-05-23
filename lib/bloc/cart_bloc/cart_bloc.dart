import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_assignment/models/cart_model.dart';
import 'package:product_assignment/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<Loadcart>((event, emit) async {
      emit(CartLoadingState());
      try {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(const CartLoadedState());
      } catch (_) {
        emit(CartErrorState());
      }
    });

    on<AddCartProduct>((event, emit) {
      final state = this.state;
      if (state is CartLoadedState) {
        try {
          emit(CartLoadedState(
            cart: CartModel(
              products: List.from(state.cart.products)..add(event.product!),
            ),
          ));
        } catch (e) {
          emit(CartErrorState());
        }
      }
    });

    on<RemovedCartProduct>((event, emit) {
      final state = this.state;
      if (state is CartLoadedState) {
        try {
          emit(CartLoadedState(
            cart: CartModel(
              products: List.from(state.cart.products)..remove(event.product!),
            ),
          ));
        } catch (e) {
          emit(CartErrorState());
        }
      }
    });
  }
}
