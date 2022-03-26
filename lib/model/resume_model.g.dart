// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume _$ResumeFromJson(Map<String, dynamic> json) => Resume(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: dateTimeFromJson(json['dateOfBirth']),
      emailAddress: json['emailAddress'] as String?,
      profileSummary: json['profileSummary'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ResumeToJson(Resume instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'profileSummary': instance.profileSummary,
      'skills': instance.skills,
      'languages': instance.languages,
      'dateOfBirth': dateTimeToJson(instance.dateOfBirth),
      'phoneNumber': instance.phoneNumber,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
