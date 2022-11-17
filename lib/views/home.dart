import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/views/font_page.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: FontSearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
        title: const Text("Font Gallery"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 0),
        ),
        actions: const [
          AnimatedToggle(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: fontList.length,
        itemBuilder: (context, index) => FontCard(
          fontModel: fontList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

class FontCard extends StatelessWidget {
  const FontCard({Key? key, required this.fontModel}) : super(key: key);
  final FontModel fontModel;
  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FontPage(fontModel: fontModel),
          ),
        );
      },
      child: Ink(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
        decoration: BoxDecoration(
          border: Border.all(color: themeContext.dividerColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fontModel.name, style: themeContext.textTheme.titleMedium),
            Text(
              fontModel.author,
              style: themeContext.textTheme.bodyMedium
                  ?.copyWith(color: themeContext.textTheme.bodySmall?.color),
            ),
            const SizedBox(height: 10),
            Text(
              "Whereas Recognition of the Inherent Dignity",
              style: fontModel.textStyle().copyWith(fontSize: 20),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({Key? key}) : super(key: key);

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late bool isDark;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    isDark = HomeController.isDarkMode.value;
    if (isDark) {
      animationController
        ..duration = const Duration(seconds: 0)
        ..forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future switchTheme() async {
    if (animationController.isAnimating) {
      return null;
    }
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    HomeController().switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: switchTheme,
      child: Lottie.asset(
        "assets/theme_switch.json",
        controller: animationController,
        onLoaded: (composition) {
          animationController.duration = composition.duration;
        },
      ),
    );
  }
}

class FontSearchDelegate extends SearchDelegate {
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
        .where((element) => element.name.toLowerCase().contains(query))
        .toList();
    if (resultsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "(^_^)b",
              style: TextStyle(fontSize: 80),
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
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: resultsList.length,
        itemBuilder: (context, index) => FontCard(
          fontModel: resultsList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
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
