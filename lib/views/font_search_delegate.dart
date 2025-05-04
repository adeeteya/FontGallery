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
            tooltip: "Clear",
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
      tooltip: "Back",
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List resultsList =
        fontList
            .where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    if (resultsList.isEmpty) {
      final int randomEmptyResultIndex = Random().nextInt(10);
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emptySearchResultEmojis[randomEmptyResultIndex],
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
              const Text(
                "We couldn't find any fonts matching that. Maybe try a different search?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
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
        ),
      );
    } else {
      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  itemCount: resultsList.length,
                  itemBuilder:
                      (context, index) =>
                          FontCard(fontModel: resultsList[index]),
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 8),
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
