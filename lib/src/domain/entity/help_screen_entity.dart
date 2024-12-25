import 'package:json_annotation/json_annotation.dart';

part 'help_screen_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class HelpScreenEntity {
  final String id;
  final String tenantId;
  final String title;
  final String description;
  final List<Option> options;

  HelpScreenEntity({
    required this.id,
    required this.tenantId,
    required this.title,
    required this.description,
    required this.options,
  });

  factory HelpScreenEntity.fromJson(Map<String, dynamic> json) =>
      _$HelpScreenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HelpScreenEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tenant {
  final String id;
  final String name;
  final String key;
  final List<ApiKey> apiKeys;

  Tenant({
    required this.id,
    required this.name,
    required this.key,
    required this.apiKeys,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  Map<String, dynamic> toJson() => _$TenantToJson(this);
}

@JsonSerializable()
class ApiKey {
  final String id;
  final String key;
  final String name;
  final bool isDevelopment;
  final int usageCount;
  final int quota;
  final List<String> allowedDomains;
  final List<String> allowedIPs;
  final List<String> allowedBundleIds;
  final List<String> allowedAndroidKeys;
  final bool active;

  ApiKey({
    required this.id,
    required this.key,
    required this.name,
    required this.isDevelopment,
    required this.usageCount,
    required this.quota,
    required this.allowedDomains,
    required this.allowedIPs,
    required this.allowedBundleIds,
    required this.allowedAndroidKeys,
    required this.active,
  });

  factory ApiKey.fromJson(Map<String, dynamic> json) => _$ApiKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ApiKeyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Option {
  final String id;
  final String helpScreenId;
  final String? parentOptionId;
  final Assistant assistant;
  final String title;
  final List<String> paragraphs;

  Option({
    required this.id,
    required this.helpScreenId,
    this.parentOptionId,
    required this.assistant,
    required this.title,
    required this.paragraphs,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Assistant {
  final String id;
  final String tenantId;
  final String name;
  final String openAIAssistantId;
  final String greeting;
  final String closing;

  Assistant({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.openAIAssistantId,
    required this.greeting,
    required this.closing,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) =>
      _$AssistantFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantToJson(this);
}