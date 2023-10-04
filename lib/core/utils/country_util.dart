import 'package:intl_phone_field/countries.dart' as country_list;

import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class _TrieNode {
  final Map<String, _TrieNode> children = {};
  country_list.Country? country;

  void insert(String word, country_list.Country country) {
    var node = this;
    for (final letter in word.toLowerCase().split('')) {
      if (!node.children.containsKey(letter)) {
        node.children[letter] = _TrieNode();
      }
      node = node.children[letter]!;
    }
    node.country = country;
  }

  country_list.Country? search(String word) {
    var node = this;
    for (final letter in word.toLowerCase().split('')) {
      if (!node.children.containsKey(letter)) {
        return null;
      }
      node = node.children[letter]!;
    }
    return node.country;
  }
}

class CountryUtil {
  static final _TrieNode _trie = _TrieNode();

  CountryUtil() {
    _initializeTrie();
  }

  void _initializeTrie() {
    for (var country in country_list.countries) {
      _trie.insert(country.name, country);
      for (var translation in country.nameTranslations.values) {
        _trie.insert(translation, country);
      }
    }
  }

  country_list.Country? getCountryByCode(String code) {
    return country_list.countries
        .firstWhereOrNull((country) => country.code == code);
  }

  // country_list.Country? getCurrentUserCountry() {
  //   return country_list.countries.firstWhereOrNull((country) =>
  //       country.code ==
  //       (sl<UserDatasource>().userDataValue.country?.code ?? 'NG'));
  // }

  Future<country_list.Country?> getCountryByName(String name) async {
    return await compute(_searchTrie, name);
  }

  static country_list.Country? _searchTrie(String name) {
    return _trie.search(name);
  }
}
