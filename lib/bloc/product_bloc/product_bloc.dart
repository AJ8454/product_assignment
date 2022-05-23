import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_assignment/models/product_model.dart';
import 'package:product_assignment/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProuctRepository _prouctRepository;
  ProductBloc(this._prouctRepository) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final productData = await _prouctRepository.getProdcut();
        emit(ProductLoadedState(productData));
      } catch (e) {
        emit(const ProductErrorState(message: "Error to get data"));
      }
    });
  }
}
