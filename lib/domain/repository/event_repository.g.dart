// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventRepositoryHash() => r'08c981a542fe137ba59a618cfd62d5060389483a';

/// See also [eventRepository].
@ProviderFor(eventRepository)
final eventRepositoryProvider = Provider<EventRepository>.internal(
  eventRepository,
  name: r'eventRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventRepositoryHash,
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

typedef EventRepositoryRef = ProviderRef<EventRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
