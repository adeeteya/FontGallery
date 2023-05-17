import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/widgets/compare_button.dart';
import 'package:font_gallery/widgets/font_card.dart';

class FontSearchDelegate extends SearchDelegate {
  final List<String> emptySearchResultEmojis = [
    "(^_^)b",
    "\\(^Д^)/",
    "(˚Δ˚)b",
    "(^-^*)",
    "(·_·)",
    "(>_<)",
    "(·.·)",
    "\\(o_o)/",
    "(≥o≤)",
    "(='X'=)",
  ];
  FontSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return (query.isEmpty)
        ? null
        : [
            IconButton(
              onPressed: () {
                query = "";
              },
              icon: const Icon(Icons.clear),
            ),
          ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List resultsList = fontList
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (resultsList.isEmpty) {
      int randomEmptyResultIndex = Random().nextInt(10);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emptySearchResultEmojis[randomEmptyResultIndex],
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            const Text(
              "Can't find any fonts.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                query = "";
                showSuggestions(context);
              },
              child: const Text("Clear your filters and try again"),
            ),
          ],
        ),
      );
    } else {
      return SafeArea(
        bottom: true,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  itemCount: resultsList.length,
                  itemBuilder: (context, index) =>
                      FontCard(fontModel: resultsList[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CompareButton(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(2),
      child: Divider(height: 0),
    );
  }
}
