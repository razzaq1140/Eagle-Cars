import 'dart:convert';
import 'package:eagle_cars/src/common/constants/text.dart';
import 'package:http/http.dart' as http;
import '../common/utils/custom_snackbar.dart';

class GoogleMapApiService {
  final String _apiKey = TextConstants.googleMapKey;
  Future<List<String>> searchPlace(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;
      return predictions
          .map((prediction) => prediction['description'] as String)
          .toList();
    } else {
      showSnackbar(
          message: 'Failed to fetch suggestions. No suggestions found!',
          isError: true);
      throw Exception('Failed to load suggestions');
    }
  }
}
