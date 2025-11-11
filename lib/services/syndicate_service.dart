import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/syndicate_model.dart';
import '../constants.dart';

class SyndicateService {
  final String baseUrl = BASE_URL;

  Future<List<SyndicateModel>> fetchSyndicates() async {
    final response = await http.get(Uri.parse('$baseUrl/api/syndicates'));

    if (response.statusCode == 200) {
      final List<dynamic> syndicatesJson = json.decode(response.body);
      return syndicatesJson
          .map((json) => SyndicateModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load syndicates');
    }
  }

  Future<SyndicateModel> getSyndicateById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/syndicates/$id'));

    if (response.statusCode == 200) {
      return SyndicateModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load syndicate');
    }
  }

  Future<List<SyndicateModel>> getSyndicatesByRouteId(String routeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/syndicates/route/$routeId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> syndicatesJson = json.decode(response.body);
      return syndicatesJson
          .map((json) => SyndicateModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load syndicates for route');
    }
  }
}
