import 'package:jupiter_clone/api.dart';

getCategory(List<String> candidateLabels, String sequenceToClassify) async {
  String answer = "";
  try {
    final result =
        await api.classifySequence(candidateLabels, sequenceToClassify);
    print('Result: $result');
    answer = '$result';
  } catch (e) {
    print('Error: $e');
    answer = candidateLabels[0];
  }

  return answer;
}
