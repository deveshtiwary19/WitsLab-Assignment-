import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WebServices {
  static Future<http.Response> getProducts() async {
    try {
      Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      //Make sure to perform error handling here accordingly
      print("Some error occured.");
      rethrow;
    }
  }
}
