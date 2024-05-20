import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/comments/comments_controller.dart';
import 'package:flutter_demo_project/state/post_details/post_details_controller.dart';
import 'package:flutter_demo_project/state/router/_router.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final PostVM post;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreen();
}

class _PostDetailScreen extends ConsumerState<PostDetailScreen> {
  late TextEditingController textController;
  late bool editModus;

  @override
  void initState() {
    editModus = false;
    textController = TextEditingController(text: widget.post.body);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    final translation = L10n();
    var comments = ref.watch(commentsControllerProvider(post.id));

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!editModus) const SizedBox(height: 10.0),
        if (!editModus)
          Text(
            post.title ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        if (!editModus)
          const Flexible(
            child: Divider(color: Color.fromARGB(255, 224, 198, 2)),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: !editModus,
              child: Expanded(
                  flex: 6,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        post.body ?? '',
                        style: const TextStyle(color: Colors.white),
                      ))),
            ),
            Visibility(
              visible: editModus,
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    maxLines: 10,
                    onSaved: (newValue) {},
                    controller: textController,
                    autofocus: true,
                    decoration: const InputDecoration(
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
                    style:
                        const TextStyle(color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!editModus)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  editModus = !editModus;
                });
                if (await ref
                            .read(postDetailsControllerProvider
                                .call(post.id!)
                                .notifier)
                            .editSinglePost() ==
                        true &&
                    editModus) {}
              },
              child: Text(
                translation.editPost,
                style: const TextStyle(color: Color.fromARGB(255, 119, 53, 53)),
              ),
            ),
          ),
        if (editModus)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: ElevatedButton.icon(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  onPressed: () async {
                    setState(() {
                      editModus = !editModus;
                    });
                    if (await ref
                                .read(postDetailsControllerProvider
                                    .call(post.id!)
                                    .notifier)
                                .editSinglePost() ==
                            true &&
                        editModus) {}
                  },
                  label: Text(
                    translation.goBack,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 119, 53, 53)),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    setState(() {
                      editModus = !editModus;
                    });
                    if (await ref
                                .read(postDetailsControllerProvider
                                    .call(post.id!)
                                    .notifier)
                                .editSinglePost() ==
                            true &&
                        editModus) {}
                  },
                  label: Text(
                    translation.save,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 119, 53, 53)),
                  ),
                ),
              ),
            ],
          ),
      ],
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () async {
                  if (post.id != null) {
                    if (await ref
                                .read(postDetailsControllerProvider
                                    .call(post.id!)
                                    .notifier)
                                .deleteSinglePost() ==
                            true &&
                        context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  translation.postDeletedSuccessfully,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ],
                          ));
                        },
                      );
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          Navigator.pop(context);
                          context.pushNamed(Routes.homeRouteName);
                        },
                      );
                    }
                  } else {
                    null;
                  }
                },
                icon: const Icon(
                  FontAwesomeIcons.trashCan,
                ),
              ),
            )
          ],
        ),
        body: comments.when(
          data: (data) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 137, 188, 230),
                      ),
                      child: Center(
                        child: topContentText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                              )
                            ],
                          ),
                          TextButton(
                            style: const ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 137, 188, 230)),
                                foregroundColor: MaterialStatePropertyAll(
                                    Colors.transparent)),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16))),
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                      expand: false,
                                      builder: (_, controller) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  height: 8.0,
                                                  width: 70.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[400],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                    controller: controller,
                                                    itemCount: data.length,
                                                    itemBuilder: (_, index) {
                                                      return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .black))),
                                                            child: ListTile(
                                                              title: Text(
                                                                data[index]
                                                                        .email ??
                                                                    "Unknown account",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              subtitle: Text(
                                                                "${data[index].body}]",
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
                            child: Text(
                                "${translation.comments} (${data.length})",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballBeat,
                    colors: [
                      Color.fromARGB(255, 192, 102, 96),
                      Color.fromARGB(255, 224, 198, 2),
                      Color.fromARGB(255, 137, 188, 230)
                    ],
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) {
            throw Error;
          },
        ));
  }
}
