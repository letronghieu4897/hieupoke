import 'package:flutter/material.dart';

class WithAdaptiveMediaQuery extends StatelessWidget {
  final Widget child;
  final double maxTextScaleFactor;

  const WithAdaptiveMediaQuery({
    Key key,
    @required this.child,
    this.maxTextScaleFactor = 1.15,
  })  : assert(child != null),
        assert(maxTextScaleFactor > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);

    var textScaleFactor = mediaData.textScaleFactor;

    if (textScaleFactor > maxTextScaleFactor) {
      textScaleFactor = maxTextScaleFactor;
    }
    if (textScaleFactor < 1) {
      textScaleFactor = 1;
    }

    return MediaQuery(
      child: child,
      data: mediaData.copyWith(
        textScaleFactor: textScaleFactor,
      ),
    );
  }
}
