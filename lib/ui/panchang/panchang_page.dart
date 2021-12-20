import 'package:astro_talk/common/colors.dart';
import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:astro_talk/data/bloc/provider/panchang_bloc.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/panchang_state.dart';
import 'package:astro_talk/data/repo/entities/panchang_data.dart';
import 'package:astro_talk/network/app_exception.dart';
import 'package:astro_talk/ui/panchang/panchang_details.dart';
import 'package:astro_talk/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'city_text_field.dart';

class PanchangPage extends StatefulWidget {
  const PanchangPage({Key? key}) : super(key: key);

  @override
  _PanchangPageState createState() => _PanchangPageState();
}

class _PanchangPageState extends State<PanchangPage> {
  late PanchangBloc panchangBloc;
  TextEditingController cityInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    panchangBloc = BlocProvider.of<PanchangBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: k16Width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kDailyPanchang,
                  style: Theme.of(context).textTheme.text18Bold(),
                ),
                SizedBox(height: k8Height),
                Text(
                  kDailyPanchangMotto,
                  style: Theme.of(context)
                      .textTheme
                      .text12Black()
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: k16Height),
                dateAndLocationSelector(),
                SizedBox(height: k16Height)
              ],
            ),
          ),
          Flexible(
            child: BlocBuilder<PanchangBloc, AstroState>(
              bloc: panchangBloc,
              builder: (context, state) {
                if (state is PanchangStateCompleted && state.data != null) {
                  PanchangData data = state.data;
                  return PanchangDetails(
                    data: data.data,
                  );
                } else if (state is PanchangStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PanchangStateError) {
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
          SizedBox(height: k16Height),
        ],
      ),
    );
  }

  Widget dateAndLocationSelector() {
    return Container(
      color: AppColors.primaryColorLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: k16Height),
          Row(
            children: [
              SizedBox(width: k16Width),
              Expanded(
                flex: 1,
                child: Text(
                  kDate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.text12BlackLight(),
                ),
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    AppUtils.instance.getDate(context).then((value) {
                      panchangBloc.selectedDate.add(value ?? DateTime.now());
                      panchangBloc.getPanchang();
                    });
                  },
                  child: Container(
                    height: k44Height,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: StreamBuilder<DateTime>(
                              stream: panchangBloc.selectedDate.stream,
                              builder: (context, snapshot) {
                                var date = snapshot.data ?? DateTime.now();
                                return Text(
                                  AppUtils.instance.getDateInFormat(date),
                                  style: Theme.of(context)
                                      .textTheme
                                      .text14Black()
                                      .copyWith(fontWeight: FontWeight.w400),
                                );
                              },
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: k16Width),
            ],
          ),
          SizedBox(height: k8Height),
          Row(
            children: [
              SizedBox(width: k16Width),
              Expanded(
                flex: 1,
                child: Text(
                  kLocation,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.text12BlackLight(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: k44Height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CityTextField(
                      onCitySelected: (placeId) {
                        panchangBloc.selectedPlaceId.add(placeId);
                        panchangBloc.getPanchang();
                      },
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: k16Width),
            ],
          ),
          SizedBox(height: k16Height),
        ],
      ),
    );
  }
}
