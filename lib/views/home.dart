import 'package:flutter/material.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/views/compare_page.dart';
import 'package:font_gallery/views/font_search_delegate.dart';
import 'package:font_gallery/widgets/compare_button.dart';
import 'package:font_gallery/widgets/font_card.dart';
import 'package:font_gallery/widgets/theme_mode_toggle.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> compareButtonAnimation;
  FontModel? selectedFontModel;
  FontModel? selectedFontModel2;

  @override
  void initState() {
    animationController = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 300);
    compareButtonAnimation = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onCompareAction(FontModel clickedFontModel) {
    //remove
    if (selectedFontModel == clickedFontModel) {
      selectedFontModel = null;
    } else if (selectedFontModel2 == clickedFontModel) {
      selectedFontModel2 = null;
    } else {
      //add
      if (selectedFontModel == null) {
        selectedFontModel = clickedFontModel;
      } else if (selectedFontModel2 == null) {
        selectedFontModel2 = clickedFontModel;
      } else {
        animationController
            .forward()
            .then((_) => animationController.reverse());
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: FontSearchDelegate(
                  selectedFontModel, selectedFontModel2, onCompareAction),
            );
          },
          icon: const Icon(Icons.search),
        ),
        title: const Text("Font Gallery"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 0),
        ),
        actions: const [ThemeModeToggle()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          (selectedFontModel == null && selectedFontModel2 == null)
              ? null
              : ScaleTransition(
                  scale: compareButtonAnimation,
                  child: CompareButton(
                    fontName: selectedFontModel?.name.substring(0, 5),
                    fontName2: selectedFontModel2?.name.substring(0, 5),
                    removeSelectedFont: () {
                      setState(() {
                        selectedFontModel = null;
                      });
                    },
                    removeSelectedFont2: () {
                      setState(() {
                        selectedFontModel2 = null;
                      });
                    },
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondAnimation) =>
                              SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: CompareFontsPage(
                              fontModel: selectedFontModel!,
                              fontModel2: selectedFontModel2!,
                              initialText: (HomeController.displayText.value
                                          .compareTo(kDefaultText) ==
                                      0
                                  ? null
                                  : HomeController.displayText.value),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      body: ListView.separated(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: fontList.length,
        itemBuilder: (context, index) => FontCard(
          fontModel: fontList[index],
          isSelected: (selectedFontModel == fontList[index] ||
              selectedFontModel2 == fontList[index]),
          onCompareAction: () => onCompareAction(fontList[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
