import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:product_assignment/models/product_model.dart';

class ProuctRepository {
  final String baseUrl =
      'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php';

  Future<List<Datum>> getProdcut() async {
    final response = await http.get(Uri.parse(baseUrl));
    final extractedData = json.decode(response.body);
    List<Datum> productData;
    try {
      productData = List.generate(
          extractedData["data"].length,
          (index) => Datum(
                id: extractedData["data"][index]["id"],
                title: extractedData["data"][index]["title"],
                status: extractedData["data"][index]["status"],
                description: extractedData["data"][index]["description"],
                featuredImage: extractedData["data"][index]["featured_image"],
                price: extractedData["data"][index]["price"],
                slug: extractedData["data"][index]["slug"],
                createdAt: extractedData["data"][index]["created_at"],
              ));
      return productData;
    } catch (e) {
      log('$e');
      return productData = [];
    }
  }
}
