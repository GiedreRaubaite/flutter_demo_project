import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late String? post;
  late String? postTitle;
  late int? postId;

  @override
  void initState() {
    post = widget.post;
    postTitle = widget.postTitle;
    postId = widget.postId != null ? int.tryParse(widget.postId!) : null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [DeletePostWidget(postId: postId)],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            flex: 10,
            child: PostDetailsScreenTopContent(
              postId: postId,
              postTitle: postTitle,
              post: post,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 2,
            child: PostDetailsScreenFooter(postId: postId),
          ),
        ],
      ),
    );
  }
}
