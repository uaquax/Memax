import 'package:flutter/material.dart';

void showError(
    {dynamic context, String title = "title", String error = "error"}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(error),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ));
}

void showSuccess(
    {dynamic context, String title = "title", String message = "message"}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ));
}
