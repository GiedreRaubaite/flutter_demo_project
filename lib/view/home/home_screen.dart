import 'package:flutter/material.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/network_connectivity/network_connectivity_controller.dart';
import 'package:flutter_demo_project/state/post_details/post_details_controller.dart';
import 'package:flutter_demo_project/state/posts/posts_controller.dart';
import 'package:flutter_demo_project/state/router/_router.dart';
import 'package:flutter_demo_project/view/shared/_shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translation = L10n();
    final list = ref.watch(postsControllerProvider);
    final refreshList = ref.read(postsControllerProvider.notifier);
    final connectivity = ref.watch(networkStatusProvider);
    return Scaffold(
        appBar: AppBar(
          leading: null,
          actions: const [LanguageToggleWidget()],
          title: Text(translation.allThePosts),
        ),
        body: list.when(
          data: (data) {
            return RefreshIndicator(
              color: const Color.fromARGB(255, 137, 188, 230),
              onRefresh: () async {
                await refreshList.refresh();
              },
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 137, 188, 230),
                      child: Text('${index + 1}'),
                    ),
                    title:
                        CroppedString(text: data[index].title, maxLength: 20),
                    subtitle:
                        CroppedString(text: data[index].body, maxLength: 4),
                    onTap: () async {
                      if (connectivity) {
                        ref.read(postDetailsControllerProvider.call(index));
                        context.goNamed(Routes.postDetailsRouteName,
                            queryParameters: {
                              "post": data[index].body ?? "",
                              "postId": data[index].id.toString(),
                              "postTitle": data[index].title ?? ""
                            });
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.white,
                              child: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                    'check your internet connection and try again'),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) {
            return ErrorWidget(stackTrace);
          },
          loading: () {
            return const LoadingWidget();
          },
        ));
  }
}
