// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safa_backend_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$safaBackendApiHash() => r'a20246026852269c25aabe2647237962e1e682d5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [safaBackendApi].
@ProviderFor(safaBackendApi)
const safaBackendApiProvider = SafaBackendApiFamily();

/// See also [safaBackendApi].
class SafaBackendApiFamily extends Family<Dio> {
  /// See also [safaBackendApi].
  const SafaBackendApiFamily();

  /// See also [safaBackendApi].
  SafaBackendApiProvider call({
    bool isMock = true,
  }) {
    return SafaBackendApiProvider(
      isMock: isMock,
    );
  }

  @override
  SafaBackendApiProvider getProviderOverride(
    covariant SafaBackendApiProvider provider,
  ) {
    return call(
      isMock: provider.isMock,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'safaBackendApiProvider';
}

/// See also [safaBackendApi].
class SafaBackendApiProvider extends Provider<Dio> {
  /// See also [safaBackendApi].
  SafaBackendApiProvider({
    bool isMock = true,
  }) : this._internal(
          (ref) => safaBackendApi(
            ref as SafaBackendApiRef,
            isMock: isMock,
          ),
          from: safaBackendApiProvider,
          name: r'safaBackendApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$safaBackendApiHash,
          dependencies: SafaBackendApiFamily._dependencies,
          allTransitiveDependencies:
              SafaBackendApiFamily._allTransitiveDependencies,
          isMock: isMock,
        );

  SafaBackendApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isMock,
  }) : super.internal();

  final bool isMock;

  @override
  Override overrideWith(
    Dio Function(SafaBackendApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SafaBackendApiProvider._internal(
        (ref) => create(ref as SafaBackendApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isMock: isMock,
      ),
    );
  }

  @override
  ProviderElement<Dio> createElement() {
    return _SafaBackendApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SafaBackendApiProvider && other.isMock == isMock;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isMock.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SafaBackendApiRef on ProviderRef<Dio> {
  /// The parameter `isMock` of this provider.
  bool get isMock;
}

class _SafaBackendApiProviderElement extends ProviderElement<Dio>
    with SafaBackendApiRef {
  _SafaBackendApiProviderElement(super.provider);

  @override
  bool get isMock => (origin as SafaBackendApiProvider).isMock;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
