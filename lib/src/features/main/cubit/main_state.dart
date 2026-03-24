import 'package:flutter/material.dart';

class MainState {
  MainStatus status;
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person
  ];
  MainState({
    this.status = MainStatus.home,
  });
}

enum MainStatus { home, search, profile, like }
