// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'84a20bbabb7cdd3d9d49e303f9d04be2c476ff51';

/// See also [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = Provider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef FirebaseAuthRef = ProviderRef<FirebaseAuth>;
String _$authFoundationHash() => r'0cc60c9cd6acb997d6c76beb95e28c712e601bc1';

/// See also [authFoundation].
@ProviderFor(authFoundation)
final authFoundationProvider = Provider<AuthFoundation>.internal(
  authFoundation,
  name: r'authFoundationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authFoundationHash,
  dependencies: <ProviderOrFamily>[firebaseAuthProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseAuthProvider,
    ...?firebaseAuthProvider.allTransitiveDependencies
  },
);

typedef AuthFoundationRef = ProviderRef<AuthFoundation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
