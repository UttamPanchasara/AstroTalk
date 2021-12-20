import 'package:astro_talk/common/colors.dart';
import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/images.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:astro_talk/data/bloc/provider/astrologer_bloc.dart';
import 'package:astro_talk/data/repo/entities/astrologer_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Filter Menu Button,
// To show pop overlay below the filter button,
// With skill and languages filter options
class FilterMenuButton extends StatefulWidget {
  final Function(List<String> skills, List<String> languages)? onFilterList;

  const FilterMenuButton({
    Key? key,
    this.onFilterList,
  }) : super(key: key);

  @override
  _FilterMenuButtonState createState() => _FilterMenuButtonState();
}

class _FilterMenuButtonState extends State<FilterMenuButton> {
  late AstrologerBloc astrologerBloc;
  final GlobalKey _menuKey = GlobalKey();
  Offset? buttonPosition;
  Size? buttonSize;
  bool isMenuOpen = false;
  OverlayEntry? _overlayEntry;
  final Map<String, bool> _skillsMap = {};
  final Map<String, bool> _languagesMap = {};

  @override
  void initState() {
    super.initState();
    astrologerBloc = BlocProvider.of<AstrologerBloc>(context);
  }

  void prepareFilterOptions() {
    if (_skillsMap.isEmpty) {
      List<Skills> skills = astrologerBloc.getAllSkills();
      for (var skill in skills) {
        if ((skill.name ?? '').isNotEmpty) {
          _skillsMap.addEntries([MapEntry(skill.name ?? '', false)]);
        }
      }
    }
    if (_languagesMap.isEmpty) {
      List<Languages> languages = astrologerBloc.getAllLanguages();
      for (var lang in languages) {
        if ((lang.name ?? '').isNotEmpty) {
          _languagesMap.addEntries([MapEntry(lang.name ?? '', false)]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleMenu();
      },
      child: Image.asset(
        AppImages.kFilter,
        fit: BoxFit.cover,
        width: 24.0,
        key: _menuKey,
      ),
    );
  }

  void toggleMenu() {
    if (isMenuOpen) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  void closeMenu() {
    // Clear filter selection on close
    _skillsMap.clear();
    _languagesMap.clear();
    _overlayEntry?.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    prepareFilterOptions();
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    if (_overlayEntry != null) {
      Overlay.of(context)?.insert(_overlayEntry!);
    }
    isMenuOpen = !isMenuOpen;
  }

  findButton() {
    RenderBox? renderBox =
        _menuKey.currentContext?.findRenderObject() as RenderBox?;
    buttonSize = renderBox?.size;
    buttonPosition = renderBox?.localToGlobal(Offset.zero);
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: (buttonPosition?.dy ?? 0) + (buttonSize?.height ?? 0),
          right: 10,
          child: Material(
            color: Colors.white,
            elevation: 7.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.70,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          kFilterByLanguages,
                          style: Theme.of(context)
                              .textTheme
                              .text14BlackLight()
                              .copyWith(color: AppColors.textColorOrange),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      ListView(
                        children: _languagesMap.keys.map(
                          (key) {
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              value: _languagesMap[key],
                              onChanged: (value) {
                                Overlay.of(context)?.setState(() {
                                  _languagesMap[key] = value!;
                                });
                              },
                              title: Text(key),
                            );
                          },
                        ).toList(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          kFilterBySkills,
                          style: Theme.of(context)
                              .textTheme
                              .text14BlackLight()
                              .copyWith(color: AppColors.textColorOrange),
                        ),
                      ),
                      SizedBox(height: k8Height),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: _skillsMap.keys.map(
                          (key) {
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              value: _skillsMap[key],
                              onChanged: (value) {
                                Overlay.of(context)?.setState(() {
                                  _skillsMap[key] = value!;
                                });
                              },
                              title: Text(key),
                            );
                          },
                        ).toList(),
                        shrinkWrap: true,
                      ),
                      SizedBox(height: k8Height),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            applyFilter();
                          },
                          child: const Text(kApply),
                        ),
                      ),
                      SizedBox(height: k8Height),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Preparing final selected skills and language list
  // To return and apply filter
  void applyFilter() {
    List<String> skills = [];
    List<String> languages = [];
    _skillsMap.forEach((key, value) {
      if (value) {
        skills.add(key);
      }
    });

    _languagesMap.forEach((key, value) {
      if (value) {
        languages.add(key);
      }
    });
    toggleMenu();
    widget.onFilterList!(skills, languages);
  }

  @override
  void dispose() {
    super.dispose();
    closeMenu();
  }
}
