import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('Fetch posts', () {
    test('Test fetch post get call', () async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      expect(response.statusCode, 200);
    });
    test('Test fetch a single post', () async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      expect(response.statusCode, 200);
    });
    test('Error when no id is given for a single post', () async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/null'));
      expect(response.statusCode, 404);
    });
  });
}
