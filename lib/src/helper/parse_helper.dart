Object parseDynamic(dynamic value) {
  final boolResult = bool.tryParse(value);
  if (boolResult != null) {
    return boolResult;
  }
  final intResult = int.tryParse(value);
  if (intResult != null) {
    return intResult;
  }
  final doubleResult = double.tryParse(value);
  if (doubleResult != null) {
    return doubleResult;
  }
  if (value is String) {
    // If it's a number, string, or boolean, return it as is

    return value as String;
  } else if (value is List) {
    // If it's a list, parse each element in the list
    return value.map((element) => parseDynamic(element)).toList();
  } else if (value is Set) {
    // If it's a set, parse each element in the set
    return value.map((element) => parseDynamic(element)).toSet();
  } else if (value is Map) {
    // If it's a map, parse each key and value in the map
    Map<Object, Object> resultMap = {};
    value.forEach((key, val) {
      resultMap[parseDynamic(key)] = parseDynamic(val);
    });
    return resultMap;
  } else if (value == null) {
    // If it's null, return null
    return value;
  }

  // For other types, return a record with the type and original value
  return {'type': value.runtimeType.toString(), 'value': value};
}
