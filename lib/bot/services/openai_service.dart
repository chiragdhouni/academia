import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  final List<Map<String, String>> messages2 = [];

 

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
  
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

}
