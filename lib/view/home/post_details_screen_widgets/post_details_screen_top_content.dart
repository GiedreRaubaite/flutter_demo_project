import 'package:flutter/material.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/_state.dart';
import 'package:flutter_demo_project/view/shared/_shared.dart';
import 'package:flutter_demo_project/view/viewmodels/_viewmodels.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PostDetailsScreenTopContent extends ConsumerStatefulWidget {
  const PostDetailsScreenTopContent(
      {super.key,
      required this.postTitle,
      required this.post,
      required this.postId});

  final String? postTitle;
  final String? post;
  final int? postId;

  @override
  ConsumerState<PostDetailsScreenTopContent> createState() =>
      _PostDetailsScreenTopContent();
}

class _PostDetailsScreenTopContent
    extends ConsumerState<PostDetailsScreenTopContent> {
  late TextEditingController textController;
  late bool editModus;

  @override
  void initState() {
    editModus = false;
    textController = TextEditingController(text: widget.post);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? post = widget.post;
    String? postTitle = widget.postTitle;
    int? postId = widget.postId;
    final translation = L10n();

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                postTitle ?? '',
                style: const TextStyle(
                    color: Color.fromARGB(255, 29, 29, 29), fontSize: 25.0),
              ),
            ),
            if (!editModus)
              const Flexible(
                child: Divider(color: Color.fromARGB(255, 224, 198, 2)),
              ),
            if (editModus)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () async {
                      setState(() {
                        editModus = !editModus;
                      });
                    },
                    label: Text(
                      translation.goBack,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 119, 53, 53)),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      setState(() {
                        editModus = !editModus;
                      });
                      if (postId != null) {
                        if (await ref
                                    .read(postDetailsControllerProvider
                                        .call(postId)
                                        .notifier)
                                    .editSinglePost(PostVM(
                                        id: postId,
                                        title: postTitle,
                                        body: post)) ==
                                true &&
                            context.mounted) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PopUpWidget(
                                text: translation.postEditedSuccessfully,
                                icon: const Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.green,
                                ),
                              );
                            },
                          );
                          Future.delayed(
                            const Duration(seconds: 1),
                            () async {
                              context.pop();
                              context.goNamed(Routes.homeRouteName);
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PopUpWidget(
                                text: translation.sorrySomethingWentWrong,
                                icon: const Icon(
                                  FontAwesomeIcons.exclamation,
                                  color: Color.fromARGB(255, 148, 32, 32),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    label: Text(
                      translation.save,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 119, 53, 53)),
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: !editModus,
                  child: Flexible(
                      flex: 6,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              post ?? '',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 54, 54, 54)),
                            ),
                          ))),
                ),
                Visibility(
                  visible: editModus,
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextField(
                        maxLines: 10,
                        controller: textController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 198, 2))),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 198, 2))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 198, 2))),
                            counterStyle: TextStyle(
                              color: Color.fromARGB(255, 224, 198, 2),
                            )),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 65, 65, 65)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!editModus)
              Container(
                padding: const EdgeInsets.all(26.0),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  key: const ValueKey('edit'),
                  onPressed: () async {
                    setState(() {
                      editModus = !editModus;
                    });
                  },
                  child: Text(
                    translation.editPost,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 119, 53, 53)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
