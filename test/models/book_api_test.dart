import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:headway/models/book.dart';

void main() {
  group('BookApi', () {
    test('fetchBook returns Book on success', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
            jsonEncode({
              'author': 'Test Author',
              'title': 'Test Title',
              'audio_url': 'audio/test.mp3',
            }),
            200);
      });

      final book = await BookApi.fetchBook(client: mockClient);
      expect(book, isNotNull);
      expect(book!.writer, 'Test Author');
      expect(book.title, 'Test Title');
      expect(book.audioFile, 'audio/test.mp3');
    });

    test('fetchBook returns null on error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not found', 404);
      });

      final book = await BookApi.fetchBook(client: mockClient);
      expect(book, isNull);
    });
  });
}
