import 'package:astro_talk/common/colors.dart';
import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/enums.dart';
import 'package:astro_talk/common/images.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:astro_talk/data/bloc/event/astrologer_event.dart';
import 'package:astro_talk/data/bloc/provider/astrologer_bloc.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/astrologer_state.dart';
import 'package:astro_talk/data/repo/entities/astrologer_data.dart';
import 'package:astro_talk/network/app_exception.dart';
import 'package:astro_talk/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'filter_menu_button.dart';
import 'sort_menu_button.dart';

class AstrologerPage extends StatefulWidget {
  const AstrologerPage({Key? key}) : super(key: key);

  @override
  _AstrologerPageState createState() => _AstrologerPageState();
}

class _AstrologerPageState extends State<AstrologerPage> {
  late AstrologerBloc astrologerBloc;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    astrologerBloc = BlocProvider.of<AstrologerBloc>(context);
    astrologerBloc.add(GetAstrologerEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: k16Width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  kTalkToAnAstrologer,
                  style: Theme.of(context).textTheme.text18Bold(),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        astrologerBloc
                            .add(ShowSearchBarEvent(visibility: true));
                        _searchFocusNode.requestFocus();
                      },
                      child: Image.asset(
                        AppImages.kSearch,
                        fit: BoxFit.cover,
                        width: 24.0,
                      ),
                    ),
                    SizedBox(width: k8Width),
                    FilterMenuButton(
                      onFilterList: (skills, languages) {
                        astrologerBloc.add(FilterAstrologerEvent(
                          languages: languages,
                          skills: skills,
                        ));
                      },
                    ),
                    SizedBox(width: k8Width),
                    SortMenuButton(
                      onSort: (SortOption? option) {
                        if (option != null) {
                          astrologerBloc
                              .add(SortAstrologerEvent(sortOption: option));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: k16Height),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: k16Width),
            child: BlocBuilder<AstrologerBloc, AstroState>(
              bloc: astrologerBloc,
              buildWhen: (context, state) {
                return state is ShowSearchBarState;
              },
              builder: (context, state) {
                var visibility = state is ShowSearchBarState && state.data;
                if (!visibility) {
                  _searchFocusNode.unfocus();
                }
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: visibility ? 60 : 0,
                  child: !visibility
                      ? Container()
                      : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          color: const Color(0xfffafafa),
                          elevation: 3,
                          child: Row(
                            children: [
                              SizedBox(width: k16Width),
                              Image.asset(
                                AppImages.kSearch,
                                fit: BoxFit.cover,
                                width: 24.0,
                              ),
                              SizedBox(width: k16Width),
                              Flexible(
                                child: TextField(
                                  focusNode: _searchFocusNode,
                                  showCursor: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .text18BlackLight(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: kSearchAstrologer,
                                    suffixIcon: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: visibility ? 1.0 : 0,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: AppColors.primaryColor,
                                        ),
                                        onPressed: () {
                                          _searchFocusNode.unfocus();
                                          astrologerBloc
                                              .add(ShowSearchBarEvent());
                                        },
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    astrologerBloc.astrologerSearchQuery
                                        .add(value.trim());
                                  },
                                  onSubmitted: (value) {
                                    _searchFocusNode.unfocus();
                                    astrologerBloc.astrologerSearchQuery
                                        .add(value.trim());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
          SizedBox(height: k8Height),
          Flexible(
            child: BlocBuilder<AstrologerBloc, AstroState>(
              bloc: astrologerBloc,
              buildWhen: (context, state) {
                return state is! ShowSearchBarState && state is! InitialState;
              },
              builder: (context, state) {
                if (state is AstrologerStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DisplayAstrologerState &&
                    state.data != null) {
                  return astrologerList(state.data ?? []);
                } else if (state is AstrologerStateError) {
                  AppException exception = state.data;
                  return Center(
                    child: Text(
                      exception.message ?? kSomethingWentWrongMessage,
                      style: Theme.of(context).textTheme.text16Grey(),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget astrologerList(List<AstrologerInfo> infoList) {
    if (infoList.isEmpty) {
      return Container();
    }
    return ListView.separated(
      itemCount: infoList.length,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: k16Width),
          child: const Divider(),
        );
      },
      shrinkWrap: true,
      itemBuilder: (context, position) {
        AstrologerInfo data = infoList[position];

        String skills = (data.skills ?? [])
            .map((skill) => skill.name ?? '')
            .toList()
            .join(', ');

        String languages = (data.languages ?? [])
            .map((language) => language.name ?? '')
            .toList()
            .join(', ');

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: k16Width),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: data.images?.medium?.imageUrl ?? '',
                height: k100Height,
                width: k100Height,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stacktrace) {
                  // Handle Error
                  return Image.memory(
                    kTransparentImage,
                    height: k100Height,
                    width: k100Height,
                  );
                },
              ),
              SizedBox(width: k16Width),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.firstName ?? ''} ${data.lastName ?? ''}'.trim(),
                      style: Theme.of(context).textTheme.text16BoldBlack(),
                    ),
                    SizedBox(height: k4Height),
                    if (skills.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.folder_special,
                            size: 16.0,
                            color: AppColors.iconColorOrange,
                          ),
                          SizedBox(width: k8Width),
                          Flexible(
                            child: Text(
                              skills,
                              style: Theme.of(context)
                                  .textTheme
                                  .text14BlackLight(),
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: k4Height),
                    if (languages.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language,
                            size: 16.0,
                            color: AppColors.iconColorOrange,
                          ),
                          SizedBox(width: k8Width),
                          Text(
                            languages,
                            style:
                                Theme.of(context).textTheme.text14BlackLight(),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: k4Height),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.money,
                          size: 16.0,
                          color: AppColors.iconColorOrange,
                        ),
                        SizedBox(width: k8Width),
                        Text(
                          '₹${data.getMinimumCallDurationCharges()}/$kMin',
                          style: Theme.of(context).textTheme.text16BoldBlack(),
                        ),
                      ],
                    ),
                    SizedBox(height: k8Height),
                    ElevatedButton(
                      onPressed: () {
                        AppUtils.instance.showToast(kComingSoon);
                      },
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.call),
                            Flexible(
                              child: Text(kTalkOnCall),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${data.getExperience().toString().trim()} $kYears'.trim(),
                style: Theme.of(context).textTheme.text15BlackLight(),
              ),
            ],
          ),
        );
      },
    );
  }
}
