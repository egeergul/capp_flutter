import 'dart:convert';

extension JSONExtensions on String {
  String truncate({int maxLength = 10}) {
    return _truncateValues(jsonDecode(this), maxLength: maxLength).toString();
  }
}

// Returns a json string with all string values truncated to the given maxLength
Map<String, dynamic> _truncateValues(Map<String, dynamic> inputJson,
    {int maxLength = 10}) {
  Map<String, dynamic> truncatedJson = {};

  inputJson.forEach((key, value) {
    if (value is String) {
      truncatedJson[key] =
          value.length > maxLength ? value.substring(0, maxLength) : value;
    } else if (value is Map<String, dynamic>) {
      // Recursive call for nested maps
      truncatedJson[key] = _truncateValues(value, maxLength: maxLength);
    } else if (value is List) {
      // Process each element of a list
      truncatedJson[key] = value.map((item) {
        if (item is String) {
          return item.length > maxLength ? item.substring(0, maxLength) : item;
        } else if (item is Map<String, dynamic>) {
          return _truncateValues(item, maxLength: maxLength);
        }
        return item; // Return non-string values as-is
      }).toList();
    } else {
      truncatedJson[key] =
          value; // Non-string, non-map, and non-list values remain unchanged
    }
  });

  return truncatedJson;
}
