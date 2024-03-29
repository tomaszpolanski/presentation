import 'package:flutter/widgets.dart';

Iterable<InlineSpan> splitMapJoin(
  String data,
  Pattern pattern, {
  required InlineSpan Function(Match match) onMatch,
  required Iterable<InlineSpan> Function(String nonMatch) onNonMatch,
}) sync* {
  var startIndex = 0;
  for (final match in pattern.allMatches(data)) {
    yield* onNonMatch(data.substring(startIndex, match.start));
    yield onMatch(match);
    startIndex = match.end;
  }
  yield* onNonMatch(data.substring(startIndex));
}
