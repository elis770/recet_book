import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final String baseUrl;

  HttpService({this.baseUrl = ''});

  /// Realizar una petición GET
  /// [url] es la URL completa o ruta relativa al baseUrl
  /// [headers] son los encabezados opcionales
  Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    try {
      final finalUrl = _buildUrl(url);
      final response = await http.get(
        Uri.parse(finalUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(response.body),
          'status': response.statusCode,
        };
      } else {
        return {
          'success': false,
          'error': 'Error: ${response.statusCode}',
          'status': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Realizar una petición POST
  /// [url] es la URL completa o ruta relativa al baseUrl
  /// [body] es el cuerpo de la petición (será convertido a JSON)
  /// [headers] son los encabezados opcionales
  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final finalUrl = _buildUrl(url);
      final defaultHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      final response = await http.post(
        Uri.parse(finalUrl),
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Realizar una petición PUT
  /// [url] es la URL completa o ruta relativa al baseUrl
  /// [body] es el cuerpo de la petición (será convertido a JSON)
  /// [headers] son los encabezados opcionales
  Future<Map<String, dynamic>> put(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final finalUrl = _buildUrl(url);
      final defaultHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      final response = await http.put(
        Uri.parse(finalUrl),
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(response.body),
          'status': response.statusCode,
        };
      } else {
        return {
          'success': false,
          'error': 'Error: ${response.statusCode}',
          'status': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Realizar una petición DELETE
  /// [url] es la URL completa o ruta relativa al baseUrl
  /// [headers] son los encabezados opcionales
  Future<Map<String, dynamic>> delete(String url,
      {Map<String, String>? headers}) async {
    try {
      final finalUrl = _buildUrl(url);
      final response = await http.delete(
        Uri.parse(finalUrl),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
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
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Construir la URL final
  String _buildUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return baseUrl.isNotEmpty ? '$baseUrl$url' : url;
  }
}