import 'dart:convert';
import 'package:http/http.dart' as http;

class api {
  static Future<String> classifySequence(
      List<String> candidateLabels, String sequenceToClassify) async {
    final url = Uri.parse('http://10.42.0.18:5000/clustering');
    print(url);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'candidate_labels': candidateLabels,
      'sequence_to_classify': sequenceToClassify
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['result'];
      return result;
    } else {
      throw Exception('Failed to classify sequence');
    }
  }
}
