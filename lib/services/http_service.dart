import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final String baseUrl;

  HttpService({this.baseUrl = ''});

  /// Generic method to handle all HTTP requests
  Future<Map<String, dynamic>> _sendRequest(
    String method,
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final finalUrl = _buildUrl(url);
      final uri = Uri.parse(finalUrl);
      final defaultHeaders = {
        if (body != null) 'Content-Type': 'application/json',
        ...?headers,
      };

      late http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Método HTTP no soportado: $method');
      }

      return processResponse(response);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Process the HTTP response. Can be overridden in subclasses to customize behavior.
  Map<String, dynamic> processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {
        'success': true,
        'data': response.body.isNotEmpty ? json.decode(response.body) : null,
        'status': response.statusCode,
      };
    } else {
      return {
        'success': false,
        'error': 'Error: ${response.statusCode}',
        'status': response.statusCode,
      };
    }
  }

  /// Realizar una petición GET
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
  }) => _sendRequest('GET', url, headers: headers);

  /// Realizar una petición POST
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) => _sendRequest('POST', url, body: body, headers: headers);

  /// Realizar una petición PUT
  Future<Map<String, dynamic>> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) => _sendRequest('PUT', url, body: body, headers: headers);

  /// Realizar una petición DELETE
  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String>? headers,
  }) => _sendRequest('DELETE', url, headers: headers);

  /// Construir la URL final
  String _buildUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return baseUrl.isNotEmpty ? '$baseUrl$url' : url;
  }
}
