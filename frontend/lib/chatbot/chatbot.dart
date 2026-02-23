import 'dart:convert';
import 'package:http/http.dart' as http;

class Chatbot {
  static const String SYSTEM_PROMPT = 'You are a helpful professional assistant.';
  static const String ENDPOINT_HOST = '10.0.2.2'; // localhost speciale per emulatore Android
  static const int ENDPOINT_PORT = 11434;
  static const String ENDPOINT_PATH = '/api/generate';
  static const String MODEL_NAME = 'smollm2:360m';
  static const bool STREAMING_MODE = false;

  Chatbot();

  void sendUserMessage(String message, Function callback) async {
    Uri uri = Uri(
      scheme: 'http',
      host: ENDPOINT_HOST,
      port: ENDPOINT_PORT,
      path: ENDPOINT_PATH,
    );

    final body = jsonEncode({
      'model': MODEL_NAME,
      'prompt': message,
      'stream': STREAMING_MODE,
    });

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        callback(data['response']);
      } else {
        callback('Error: ${response.statusCode}');
      }
    } catch (e) {
      callback('Exception: $e');
    }
  }
}
