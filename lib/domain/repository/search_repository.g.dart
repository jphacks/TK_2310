// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchRepositoryHash() => r'ad9d3a7445fd895cd3fbe1cef8a10dda7a6a0ae3';

/// See also [searchRepository].
@ProviderFor(searchRepository)
final searchRepositoryProvider = Provider<SearchRepository>.internal(
  searchRepository,
  name: r'searchRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchRepositoryHash,
  dependencies: <ProviderOrFamily>[
    authFoundationProvider,
    safaBackendApiProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    authFoundationProvider,
    ...?authFoundationProvider.allTransitiveDependencies,
    safaBackendApiProvider,
    ...?safaBackendApiProvider.allTransitiveDependencies
  },
);

typedef SearchRepositoryRef = ProviderRef<SearchRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
