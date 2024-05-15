import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.post});

  final PostVM post;

  @override
  Widget build(BuildContext context) {
    final translation = L10n();

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Text(
          post.title ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        const Flexible(
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      post.body ?? '',
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () => {},
              child: Text(translation.editPost,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 119, 53, 53))),
            ))
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              FontAwesomeIcons.trashCan,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 137, 188, 230),
            ),
            child: Center(
              child: topContentText,
            ),
          ),
          Flexible(
            child: Padding(
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
                  Text(
                    "${translation.comments} (5)",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
