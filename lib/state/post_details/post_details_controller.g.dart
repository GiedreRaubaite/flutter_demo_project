// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postDetailsControllerHash() =>
    r'3dcc102ea1234121319f4187c70e4123d962c6ba';

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

abstract class _$PostDetailsController
    extends BuildlessAutoDisposeAsyncNotifier<PostVM> {
  late final int id;

  FutureOr<PostVM> build(
    int id,
  );
}

/// See also [PostDetailsController].
@ProviderFor(PostDetailsController)
const postDetailsControllerProvider = PostDetailsControllerFamily();

/// See also [PostDetailsController].
class PostDetailsControllerFamily extends Family<AsyncValue<PostVM>> {
  /// See also [PostDetailsController].
  const PostDetailsControllerFamily();

  /// See also [PostDetailsController].
  PostDetailsControllerProvider call(
    int id,
  ) {
    return PostDetailsControllerProvider(
      id,
    );
  }

  @override
  PostDetailsControllerProvider getProviderOverride(
    covariant PostDetailsControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postDetailsControllerProvider';
}

/// See also [PostDetailsController].
class PostDetailsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostDetailsController,
        PostVM> {
  /// See also [PostDetailsController].
  PostDetailsControllerProvider(
    int id,
  ) : this._internal(
          () => PostDetailsController()..id = id,
          from: postDetailsControllerProvider,
          name: r'postDetailsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postDetailsControllerHash,
          dependencies: PostDetailsControllerFamily._dependencies,
          allTransitiveDependencies:
              PostDetailsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PostDetailsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<PostVM> runNotifierBuild(
    covariant PostDetailsController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PostDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostDetailsControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostDetailsController, PostVM>
      createElement() {
    return _PostDetailsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDetailsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostDetailsControllerRef on AutoDisposeAsyncNotifierProviderRef<PostVM> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PostDetailsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostDetailsController,
        PostVM> with PostDetailsControllerRef {
  _PostDetailsControllerProviderElement(super.provider);

  @override
  int get id => (origin as PostDetailsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
