import 'package:flutter/material.dart';
import 'package:flutter_demo_project/l10n/generated/l10n.dart';
import 'package:flutter_demo_project/state/_state.dart';
import 'package:flutter_demo_project/view/shared/_shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DeletePostWidget extends ConsumerWidget {
  const DeletePostWidget({super.key, required this.postId});

  final int? postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = L10n();

    return Padding(
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
                  return PopUpWidget(
                    text: translation.postDeletedSuccessfully,
                    icon: const Icon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                    ),
                  );
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
        icon: const Icon(
          FontAwesomeIcons.trashCan,
        ),
      ),
    );
  }
}
