import 'package:astro_talk/common/colors.dart';
import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/enums.dart';
import 'package:astro_talk/common/images.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:flutter/material.dart';

// Sort Menu Button,
// To show pop overlay below the sort button,
// With different sorting options
class SortMenuButton extends StatefulWidget {
  final Function(SortOption?)? onSort;

  const SortMenuButton({
    Key? key,
    this.onSort,
  }) : super(key: key);

  @override
  _SortMenuButtonState createState() => _SortMenuButtonState();
}

class _SortMenuButtonState extends State<SortMenuButton> {
  final GlobalKey _menuKey = GlobalKey();
  SortOption? _sortOption;

  Offset? buttonPosition;
  Size? buttonSize;
  bool isMenuOpen = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleMenu();
      },
      child: Image.asset(
        AppImages.kSort,
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
    // Clear sort option on close
    _sortOption = null;
    _overlayEntry?.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        kSortBy,
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
                    menuButton(SortOption.experienceHighToLow),
                    menuButton(SortOption.experienceLowToHigh),
                    menuButton(SortOption.priceHighToLow),
                    menuButton(SortOption.priceLowToHigh),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget menuButton(SortOption option) {
    return GestureDetector(
      onTap: () {
        toggleMenu();
        setState(() {
          _sortOption = option;
        });
        widget.onSort!(_sortOption);
      },
      child: Row(
        children: [
          Radio(
            value: option,
            groupValue: _sortOption,
            onChanged: (value) {},
          ),
          Flexible(
            child: Text(
              option.name,
              style: Theme.of(context).textTheme.text16BlackLight(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    closeMenu();
  }
}
