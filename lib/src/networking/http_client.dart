import 'dart:convert';
import 'dart:io' as dio;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpClient {
  final String baseUrl;
  final String bearerToken;
  final bool allowUntrustedSsl;

  HttpClient({
    required this.baseUrl,
    required this.bearerToken,
    required this.allowUntrustedSsl,
  });

  Future<http.Response> get(String path) async {
    final response = await createHttpClient().get(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  Future<http.Response> post(String path, dynamic data) async {
    final response = await createHttpClient().post(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    return response;
  }

  Future<http.Response> put(String path, dynamic data) async {
    final response = await createHttpClient().put(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    return response;
  }

  Future<http.Response> delete(String path) async {
    final response = await createHttpClient().delete(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  http.Client createHttpClient() {
    final client = dio.HttpClient();

    if (allowUntrustedSsl) {
      client.badCertificateCallback =
          (dio.X509Certificate cert, String host, int port) => true;
    }
    return IOClient(client);
  }
}
