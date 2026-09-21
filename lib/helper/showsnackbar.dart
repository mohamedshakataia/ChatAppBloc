import 'package:flutter/material.dart';

void messagesnackbar(BuildContext context, String messaage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messaage)));
}
