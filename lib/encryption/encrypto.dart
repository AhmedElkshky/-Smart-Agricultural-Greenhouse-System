import 'dart:convert';

import 'package:crypto/crypto.dart';

class RC4 {
  /// A simple RC4 encryptor.

  /// The key.

  List<int> get key => _key;

  late List<int> _key;

  late List<int> _box;

  int _i = 0, _j = 0;

  /// Creates a new instance by passing a given [key].

  RC4(String key) {
    _key = utf8.encode(key);

    _makeBox();
  }

  /// Creates a new instance by passing a given [key].

  RC4.fromBytes(List<int> key) {
    _key = key;

    _makeBox();
  }
  void _makeBox() {
    var x = 0;

    var box = List.generate(256, (i) => i);

    for (var i = 0; i < 256; i++) {
      x = (x + box[i] + _key[i % _key.length]) % 256;

      _swap(box, i, x);
    }

    _box = box;
  }

  void _swap(List<int> list, int i, int j) {
    var tmp = list[i];

    list[i] = list[j];

    list[j] = tmp;
  }

  List<int> _crypt(List<int> message) {
    var out = <int>[];

    for (var char in message) {
      _i = (_i + 1) % 256;

      _j = (_j + _box[_i]) % 256;

      _swap(_box, _i, _j);

      final c = char ^ (_box[(_box[_i] + _box[_j]) % 256]);
      out.add(c);
    }

    return out;
  }

  List<int> encryption(List<int> bytes) => _crypt(bytes);

  String decryption(List<int> bytes, [bool allowMalformed = false]) =>
      utf8.decode(_crypt(bytes), allowMalformed: allowMalformed);
}


