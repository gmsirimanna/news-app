import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/data/repository/exception/generic_error_indicator.dart';
import 'package:news_app/data/repository/exception/no_connection_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    @required this.error,
    this.onTryAgain,
    Key key,
  })  : assert(error != null),
        super(key: key);

  final dynamic error;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => error is SocketException
      ? NoConnectionIndicator(
          onTryAgain: onTryAgain,
        )
      : GenericErrorIndicator(
          onTryAgain: onTryAgain,
        );
}
