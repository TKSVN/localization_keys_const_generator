import 'package:yaml/yaml.dart';

/// Converts a [YamlMap] to a [Map<String, dynamic>]
Map<String, dynamic> yamlMapToMap(YamlMap yamlMap) {
  Map<String, dynamic> map = {};
  yamlMap.forEach((key, value) {
    if (value is YamlMap) {
      map[key.toString()] = yamlMapToMap(value); // Recursively convert nested YamlMap
    } else if (value is YamlList) {
      map[key.toString()] = yamlListToList(value); // Handle lists
    } else {
      map[key.toString()] = value; // Add scalar values directly
    }
  });
  return map;
}

/// Converts a [YamlList] to a [List<dynamic>]
List<dynamic> yamlListToList(YamlList yamlList) {
  return yamlList.map((item) {
    if (item is YamlMap) {
      return yamlMapToMap(item); // Recursively convert nested YamlMap
    } else if (item is YamlList) {
      return yamlListToList(item); // Recursively convert nested YamlList
    } else {
      return item; // Add scalar values directly
    }
  }).toList();
}
