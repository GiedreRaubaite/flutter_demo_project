// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "allThePosts": MessageLookupByLibrary.simpleMessage("All the posts"),
        "checkYourInternetConnection": MessageLookupByLibrary.simpleMessage(
            "Check your internet connection and try again"),
        "comments": MessageLookupByLibrary.simpleMessage("Comments"),
        "editPost": MessageLookupByLibrary.simpleMessage("Edit post"),
        "goBack": MessageLookupByLibrary.simpleMessage("Back"),
        "noPostWereFound": MessageLookupByLibrary.simpleMessage(
            "Hmmm.. It looks like no posts were found..."),
        "postDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Post deleted successfully"),
        "postEditedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Post edited successfully"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "sorrySomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "We are very sorry, but something went wrong..."),
        "unknownAccount":
            MessageLookupByLibrary.simpleMessage("Unknown account")
      };
}
