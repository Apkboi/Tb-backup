// Provider for the list of country names
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';

///Countries
final countryNamesProvider = Provider<List<String>>((ref) {
  final countries = ref.read(setupProfileProvider.notifier).countries;
  return countries.map((e) => e.name!).toList();
});

final countryByNameProvider =
    Provider.family<CountriesData?, String>((ref, name) {
  final countries = ref.read(setupProfileProvider.notifier).countries;
  return countries.firstWhereOrNull(
    (country) => country.name == name,
  );
});
final countryByIdProvider = Provider.family<CountriesData?, num?>((ref, id) {
  final countries = ref.read(setupProfileProvider.notifier).countries;
  return countries.firstWhereOrNull(
    (country) => country.id == id,
  );
});

///Languages
final languagesNamesProvider = Provider<List<String>>((ref) {
  final countries = ref.read(setupProfileProvider.notifier).languages;
  return countries.map((e) => e.name!).toList();
});

final languageByNameProvider = Provider.family<Languages?, String>((ref, name) {
  final countries = ref.read(setupProfileProvider.notifier).languages;
  return countries.firstWhereOrNull(
    (country) => country.name == name,
  );
});
final languageByIdProvider = Provider.family<Languages?, num?>((ref, name) {
  final countries = ref.read(setupProfileProvider.notifier).languages;
  return countries.firstWhereOrNull(
    (country) => country.id == name,
  );
});

///Tribes
final tribeNamesProvider = Provider<List<String>>((ref) {
  final countries = ref.read(setupProfileProvider.notifier).tribes;
  return countries.map((e) => e.name ?? 'n/a').toList();
});

final tribeByNameProvider = Provider.family<Tribes?, String>((ref, name) {
  final countries = ref.read(setupProfileProvider.notifier).tribes;

  return countries.firstWhereOrNull(
    (country) => country.name == name,
  );
});
final tribeByIdProvider = Provider.family<Tribes?, num?>((ref, name) {
  final countries = ref.read(setupProfileProvider.notifier).tribes;

  return countries.firstWhereOrNull(
    (country) => country.id == name,
  );
});

final interestByIdProvider = Provider.family<Interests?, num?>((ref, name) {
  final interests = ref.read(setupProfileProvider.notifier).interests;

  return interests.firstWhereOrNull(
    (interest) => interest.id == name,
  );
});

final hashTagByIdProvider = Provider.family<Hashtags?, num?>((ref, name) {
  final hashtags = ref.read(setupProfileProvider.notifier).hashtags;

  return hashtags.firstWhereOrNull(
        (hashtag) => hashtag.id == name,
  );
});
