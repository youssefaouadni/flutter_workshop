import 'dart:async';

import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final Function(String) onChanged;
  Timer? searchOnStoppedTyping;

  SearchFieldWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          const duration = Duration(milliseconds: 800);
          if (searchOnStoppedTyping != null) {
            searchOnStoppedTyping!.cancel();
          }
          searchOnStoppedTyping = Timer(duration, () => onChanged(value));
        },
        decoration: const InputDecoration(
          labelText: 'Search',
          hintText: 'Type to search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
