// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_screen_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpScreenEntity _$HelpScreenEntityFromJson(Map<String, dynamic> json) =>
    HelpScreenEntity(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      chatWithUs: json['chatWithUs'] as bool?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HelpScreenEntityToJson(HelpScreenEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'title': instance.title,
      'description': instance.description,
      'chatWithUs': instance.chatWithUs,
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      id: json['id'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      apiKeys: (json['apiKeys'] as List<dynamic>?)
          ?.map((e) => ApiKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'key': instance.key,
      'apiKeys': instance.apiKeys?.map((e) => e.toJson()).toList(),
    };

ApiKey _$ApiKeyFromJson(Map<String, dynamic> json) => ApiKey(
      id: json['id'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      isDevelopment: json['isDevelopment'] as bool,
      usageCount: (json['usageCount'] as num).toInt(),
      quota: (json['quota'] as num).toInt(),
      allowedDomains: (json['allowedDomains'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowedIPs: (json['allowedIPs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowedBundleIds: (json['allowedBundleIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowedAndroidKeys: (json['allowedAndroidKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$ApiKeyToJson(ApiKey instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'isDevelopment': instance.isDevelopment,
      'usageCount': instance.usageCount,
      'quota': instance.quota,
      'allowedDomains': instance.allowedDomains,
      'allowedIPs': instance.allowedIPs,
      'allowedBundleIds': instance.allowedBundleIds,
      'allowedAndroidKeys': instance.allowedAndroidKeys,
      'active': instance.active,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      id: json['id'] as String,
      helpScreenId: json['helpScreenId'] as String,
      parentOptionId: json['parentOptionId'] as String?,
      assistant: json['assistant'] == null
          ? null
          : Assistant.fromJson(json['assistant'] as Map<String, dynamic>),
      title: json['title'] as String,
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      files: json['files'] as List<dynamic>?,
      chatWithUs: json['chatWithUs'] as bool?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'helpScreenId': instance.helpScreenId,
      'parentOptionId': instance.parentOptionId,
      'assistant': instance.assistant?.toJson(),
      'title': instance.title,
      'paragraphs': instance.paragraphs,
      'files': instance.files,
      'chatWithUs': instance.chatWithUs,
    };

Assistant _$AssistantFromJson(Map<String, dynamic> json) => Assistant(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      name: json['name'] as String,
      openAIAssistantId: json['openAIAssistantId'] as String,
      greeting: json['greeting'] as String,
      closing: json['closing'] as String,
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssistantToJson(Assistant instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'tenant': instance.tenant?.toJson(),
      'name': instance.name,
      'openAIAssistantId': instance.openAIAssistantId,
      'greeting': instance.greeting,
      'closing': instance.closing,
      'limit': instance.limit,
    };
