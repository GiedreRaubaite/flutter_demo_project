import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/comments/comments_controller.dart';
import 'package:flutter_demo_project/state/post_details/post_details_controller.dart';
import 'package:flutter_demo_project/state/router/_router.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:flutter_demo_project/view/shared/_shared.dart';
import 'package:flutter_demo_project/view/viewmodels/post_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen(
      {super.key,
      required this.post,
      required this.postId,
      required this.postTitle});

  final String? post;
  final String? postTitle;
  final String? postId;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreen();
}

class _PostDetailScreen extends ConsumerState<PostDetailScreen> {
  late TextEditingController textController;
  late bool editModus;
  late String? post;
  late String? postTitle;
  late int? postId;

  @override
  void initState() {
    post = widget.post;
    postTitle = widget.postTitle;
    postId = widget.postId != null ? int.tryParse(widget.postId!) : null;
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
    final translation = L10n();
    var comments = ref.watch(commentsControllerProvider(postId));

    final topContentText = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: !editModus,
              child: Expanded(
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
                  child: AutoSizeTextField(
                    maxLines: null,
                    controller: textController,
                    autofocus: true,
                    minFontSize: 15,
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
            padding: const EdgeInsets.all(26.0),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  editModus = !editModus;
                });
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
              ElevatedButton.icon(
                icon: const Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () async {
                  setState(() {
                    editModus = !editModus;
                  });
                },
                label: Text(
                  translation.goBack,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 119, 53, 53)),
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
                                    .call(postId!)
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
                                  translation.postEditedSuccessfully,
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
                        () async {
                          Navigator.pop(context);
                          context.pop();

                          context.goNamed(Routes.homeRouteName);
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.exclamation,
                                color: Color.fromARGB(255, 148, 32, 32),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  translation.sorrySomethingWentWrong,
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
                    }
                  }
                },
                label: Text(
                  translation.save,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 119, 53, 53)),
                ),
              ),
            ],
          ),
      ],
    );

    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () async {
                  if (postId != null) {
                    if (await ref
                                .read(postDetailsControllerProvider
                                    .call(postId!)
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
                          context.goNamed(Routes.homeRouteName);
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.exclamation,
                                color: Color.fromARGB(255, 148, 32, 32),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  translation.sorrySomethingWentWrong,
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
                    }
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
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 10,
                      child: topContentText,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
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
                                  overlayColor: WidgetStatePropertyAll(
                                      Color.fromARGB(255, 137, 188, 230)),
                                  foregroundColor: WidgetStatePropertyAll(
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
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    height: 8.0,
                                                    width: 70.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[400],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
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
                                                                          color:
                                                                              Colors.black))),
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
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const LoadingWidget(),
          error: (error, stackTrace) {
            throw Error;
          },
        ));
  }
}
