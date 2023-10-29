// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventDetailRepositoryHash() =>
    r'e756f59e798d1c1ee1b7252df161c851708bd373';

/// See also [eventDetailRepository].
@ProviderFor(eventDetailRepository)
final eventDetailRepositoryProvider = Provider<EventDetailRepository>.internal(
  eventDetailRepository,
  name: r'eventDetailRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventDetailRepositoryHash,
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

typedef EventDetailRepositoryRef = ProviderRef<EventDetailRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
