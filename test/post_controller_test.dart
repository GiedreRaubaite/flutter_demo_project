import 'package:flutter_demo_project/state/_state.dart';
import 'package:flutter_demo_project/state/posts/posts_controller.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'post_controller_test.g.dart';

@riverpod
class MyNotifier extends _$MyNotifier implements PostsController {
  @override
  Future<List<PostVM>> build() async {
    return List.generate(
      150,
      (index) {
        return PostVM(
            id: index,
            userId: index,
            title: 'mockUpTitle',
            body: 'mockUpBody$index');
      },
    );
  }

  @override
  Future<void> refresh() async {}
}

class MockAuthRepository extends Mock implements MyNotifier {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer makeProviderContainer() {
    final container = ProviderContainer(
      overrides: [postsControllerProvider.overrideWith(() => MyNotifier())],
    );
    return container;
  }

  test('postControler returns list of PostVM', () async {
    final container = makeProviderContainer();
    final listener = Listener<AsyncValue<void>>();
    container.listen(
      postsControllerProvider,
      listener.call,
      fireImmediately: true,
    );

    expect(
      container.read(postsControllerProvider),
      const AsyncValue<List<PostVM>>.loading(),
    );

    container.read(postsControllerProvider.notifier);
    await container.read(postsControllerProvider.future);
    expect(
        container.read(postsControllerProvider).value?.first,
        isA<PostVM>()
            .having((s) => s.id, 'id', 0)
            .having((s) => s.userId, 'userId', 0)
            .having((s) => s.title, 'title', 'mockUpTitle')
            .having((s) => s.body, 'body', 'mockUpBody0'));
  });
}
