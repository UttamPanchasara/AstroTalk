import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/data/bloc/provider/location_bloc.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/location_state.dart';
import 'package:astro_talk/data/repo/entities/location_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astro_talk/common/text_style_extension.dart';

class CityTextField extends StatefulWidget {
  final Function(String)? onCitySelected;

  const CityTextField({
    Key? key,
    this.onCitySelected,
  }) : super(key: key);

  @override
  _CityTextFieldState createState() => _CityTextFieldState();
}

class _CityTextFieldState extends State<CityTextField> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size?.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, (size?.height ?? 0) + 5.0),
          child: Material(
            elevation: 4.0,
            child: BlocBuilder<LocationBloc, AstroState>(
              bloc: locationBloc,
              builder: (context, state) {
                if (state is LocationStateCompleted && state.data != null) {
                  LocationData? data = state.data;
                  if ((data?.data ?? []).isEmpty) {
                    return Container();
                  }
                  return SizedBox(
                    height: 160,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: (data?.data ?? []).map((value) {
                        return ListTile(
                          title: Text(
                            '${value.placeName}',
                            style: Theme.of(context)
                                .textTheme
                                .text14Black()
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          onTap: () {
                            widget.onCitySelected!(value.placeId ?? '');
                            _focusNode.unfocus();
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              showCursor: true,
              style: Theme.of(context)
                  .textTheme
                  .text14Black()
                  .copyWith(fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: kCityName,
                contentPadding: EdgeInsets.only(bottom: 5.0),
              ),
              onChanged: (value) {
                locationBloc.locationInputQuery.add(value.trim());
              },
            ),
          ),
          BlocBuilder<LocationBloc, AstroState>(
            bloc: locationBloc,
            builder: (context, state) {
              if (state is LocationStateLoading) {
                return SizedBox(
                  width: k16Width,
                  height: k16Width,
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(width: 4.0),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}
