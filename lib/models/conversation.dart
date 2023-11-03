import 'dart:convert';

class Conversation {
  final String companyId;
  final String employeeEmail;
  final Inference inference;
  final String streamUrl;

  Conversation({
    required this.companyId,
    required this.employeeEmail,
    required this.inference,
    required this.streamUrl,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      companyId: json['company_id'] as String,
      employeeEmail: json['employee_email'] as String,
      inference: Inference.fromJson(json['inference']),
      streamUrl: json['stream_url'] as String,
    );
  }


}

class Inference {
  final List<String> conversationTranscript;
  final double score;
  final String sentiment;
  final String summary;

  Inference({
    required this.conversationTranscript,
    required this.score,
    required this.sentiment,
    required this.summary,
  });

  factory Inference.fromJson(Map<String, dynamic> json) {
    return Inference(
      conversationTranscript: List<String>.from(json['conversation_transcript'] as List<dynamic>),
      score: (json['score'] as num).toDouble(),
      sentiment: json['sentiment'] as String,
      summary: json['summary'] as String,
    );
  }
}
