import 'dart:io';

convert(value) {
  return Platform.isWindows ? Uri.encodeComponent(value.toString()) : value;
}

Future<Map<String, String>> authToJson(Auth data) async {
  return data.token != ''
      ? {
          'Content-Type': 'application/json',
          'authorization': 'Bearer ${data.token}',
          // 'Api-Key': dotenv.get('API-KEY', fallback: 'null'),
        }
      : {
          'Content-Type': 'application/json',
          // 'Api-Key': dotenv.get('API-KEY', fallback: 'null'),
        };
}

class Auth {
  Auth({
    this.token = '',
  });
  String token;
}
