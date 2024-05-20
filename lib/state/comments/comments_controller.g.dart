// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsControllerHash() =>
    r'e9619a1272bc1673bc41fa319d3e0ecfe07ce620';

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

abstract class _$CommentsController
    extends BuildlessAutoDisposeAsyncNotifier<List<CommentVM>> {
  late final int? id;

  FutureOr<List<CommentVM>> build(
    int? id,
  );
}

/// See also [CommentsController].
@ProviderFor(CommentsController)
const commentsControllerProvider = CommentsControllerFamily();

/// See also [CommentsController].
class CommentsControllerFamily extends Family<AsyncValue<List<CommentVM>>> {
  /// See also [CommentsController].
  const CommentsControllerFamily();

  /// See also [CommentsController].
  CommentsControllerProvider call(
    int? id,
  ) {
    return CommentsControllerProvider(
      id,
    );
  }

  @override
  CommentsControllerProvider getProviderOverride(
    covariant CommentsControllerProvider provider,
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
  String? get name => r'commentsControllerProvider';
}

/// See also [CommentsController].
class CommentsControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentsController, List<CommentVM>> {
  /// See also [CommentsController].
  CommentsControllerProvider(
    int? id,
  ) : this._internal(
          () => CommentsController()..id = id,
          from: commentsControllerProvider,
          name: r'commentsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsControllerHash,
          dependencies: CommentsControllerFamily._dependencies,
          allTransitiveDependencies:
              CommentsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  CommentsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int? id;

  @override
  FutureOr<List<CommentVM>> runNotifierBuild(
    covariant CommentsController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(CommentsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CommentsController, List<CommentVM>>
      createElement() {
    return _CommentsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<CommentVM>> {
  /// The parameter `id` of this provider.
  int? get id;
}

class _CommentsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentsController,
        List<CommentVM>> with CommentsControllerRef {
  _CommentsControllerProviderElement(super.provider);

  @override
  int? get id => (origin as CommentsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
