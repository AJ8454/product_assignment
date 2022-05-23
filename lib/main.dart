import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_assignment/bloc/cart_bloc/cart_bloc.dart';
import 'package:product_assignment/bloc/product_bloc/product_bloc.dart';
import 'package:product_assignment/repository/product_repository.dart';
import 'package:product_assignment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ProuctRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
              create: (context) =>
                  ProductBloc(RepositoryProvider.of<ProuctRepository>(context))
                    ..add(LoadProductEvent())),
          BlocProvider(
            create: (context) => CartBloc()..add(Loadcart()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Product Assig',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
