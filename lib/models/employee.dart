import 'dart:convert';
import 'package:flutter/material.dart';
class EmployeeData {
  final String averageSentiment;
  final String companyId;
  final String employeeEmail;
  final int numConversations;
  final int numNegativeConversations;
  final int numNeutralConversations;
  final int numPositiveConversations;
  final double score;

  EmployeeData({
    required this.averageSentiment,
    required this.companyId,
    required this.employeeEmail,
    required this.numConversations,
    required this.numNegativeConversations,
    required this.numNeutralConversations,
    required this.numPositiveConversations,
    required this.score,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      averageSentiment: json['average_sentiment'],
      companyId: json['company_id'],
      employeeEmail: json['employee_email'],
      numConversations: json['num_conversations'],
      numNegativeConversations: json['num_negative_conversations'],
      numNeutralConversations: json['num_neutral_conversations'],
      numPositiveConversations: json['num_positive_conversations'],
      score: json['score'].toDouble(),
    );
  }
}
