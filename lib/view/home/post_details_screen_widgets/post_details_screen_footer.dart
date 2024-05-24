import 'package:flutter/material.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/_state.dart';
import 'package:flutter_demo_project/view/shared/_shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetailsScreenFooter extends ConsumerStatefulWidget {
  const PostDetailsScreenFooter({super.key, required this.postId});

  final int? postId;

  @override
  ConsumerState<PostDetailsScreenFooter> createState() =>
      _PostDetailsScreenFooter();
}

class _PostDetailsScreenFooter extends ConsumerState<PostDetailsScreenFooter> {
  late bool heart;
  late bool thumbsUp;

  @override
  void initState() {
    heart = false;
    thumbsUp = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var comments = ref.watch(commentsControllerProvider(widget.postId));

    final translation = L10n();
    return comments.when(
      data: (comments) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            thumbsUp = !thumbsUp;
                          });
                        },
                        child: Icon(
                          thumbsUp
                              ? FontAwesomeIcons.solidThumbsUp
                              : FontAwesomeIcons.thumbsUp,
                          color: Colors.blue,
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        heart = !heart;
                      });
                    },
                    child: Icon(
                      heart
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              TextButton(
                style: const ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 137, 188, 230)),
                    foregroundColor:
                        WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    builder: (context) {
                      return DraggableScrollableSheet(
                          expand: false,
                          builder: (_, controller) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 8.0,
                                      width: 70.0,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                        controller: controller,
                                        itemCount: comments.length,
                                        itemBuilder: (_, index) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black))),
                                                child: ListTile(
                                                  title: Text(
                                                    comments[index].email ??
                                                        translation
                                                            .unknownAccount,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    "${comments[index].body}]",
                                                    maxLines: 15,
                                                  ),
                                                ),
                                              ));
                                        }),
                                  )
                                ],
                              ));
                    },
                  );
                },
                child: Text("${translation.comments} (${comments.length})",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue)),
              )
            ],
          ),
        );
      },
      loading: () => const LoadingWidget(),
      error: (error, stackTrace) {
        throw Error;
      },
    );
  }
}
