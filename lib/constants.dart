import 'dart:convert';
import 'dart:developer';

String? numberTobase64(var result) {
  try {
    String base64String = base64.encode(utf8.encode(result.toString()));

    log(base64String);
    return base64String;
  } catch (e) {
    return null;
  }
}
