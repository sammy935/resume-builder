import 'package:json_annotation/json_annotation.dart';
import 'package:resume_builder/utils/base_methods.dart';

part 'resume_model.g.dart';

@JsonSerializable()
class Resume {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? emailAddress;
  final String? profileSummary;
  final List<String>? skills;
  final List<String>? languages;
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Resume({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.emailAddress,
    this.profileSummary,
    this.skills,
    this.languages,
    required this.phoneNumber,
    required this.createdAt,
    this.updatedAt,
  });

  factory Resume.fromJson(Map<String, dynamic> json) => _$ResumeFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeToJson(this);

  Resume copyWith({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? emailAddress,
    String? phoneNumber,
    List<String>? languages,
    List<String>? skills,
    String? profileSummary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Resume(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      languages: languages ?? this.languages,
      profileSummary: profileSummary ?? this.profileSummary,
      skills: skills ?? this.skills,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      id: id,
    );
  }
}
