import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/common/size_constant.dart';
import 'package:astro_talk/data/repo/entities/panchang_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astro_talk/common/text_style_extension.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class PanchangDetails extends StatefulWidget {
  final PanchangInfo? data;

  const PanchangDetails({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  _PanchangDetailsState createState() => _PanchangDetailsState();
}

class _PanchangDetailsState extends State<PanchangDetails> {
  PanchangInfo? data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: k16Width),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                sunriseTiming(kSunrise, data?.sunrise ?? ''),
                verticalDivider(),
                sunriseTiming(kSunset, data?.sunset ?? ''),
                verticalDivider(),
                sunriseTiming(kMoonrise, data?.moonrise ?? ''),
                verticalDivider(),
                sunriseTiming(kMoonset, data?.moonset ?? ''),
              ],
            ),
          ),
          SizedBox(height: k16Height),
          tInfo(data?.tithi),
          SizedBox(height: k16Height),
          nakInfo(data?.nakshatra),
          SizedBox(height: k16Height),
          yogInfo(data?.yog),
          SizedBox(height: k16Height),
          karanInfo(data?.karan),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget tInfo(Tithi? tithi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(kTithi),
        infoDetail(
          '$kTithi $kNumber',
          (tithi?.details?.tithiNumber ?? '').toString(),
        ),
        infoDetail(
          '$kTithi $kName',
          (tithi?.details?.tithiName ?? '').toString(),
        ),
        infoDetail(
          kSpecial,
          (tithi?.details?.special ?? '').toString(),
        ),
        infoDetail(
          kSummary,
          (tithi?.details?.summary ?? '').toString(),
        ),
        infoDetail(
          kDeity,
          (tithi?.details?.deity ?? '').toString(),
        ),
        infoDetail(
          kEndTime,
          ('${tithi?.endTime?.hour ?? 0} hr ${tithi?.endTime?.minute ?? 0} min ${tithi?.endTime?.second ?? 0} sec')
              .toString(),
        ),
      ],
    );
  }

  Widget nakInfo(Nakshatra? nak) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(kNakshatra),
        infoDetail(
          '$kNakshatra $kNumber',
          (nak?.details?.nakNumber ?? '').toString(),
        ),
        infoDetail(
          '$kNakshatra $kName',
          (nak?.details?.nakName ?? '').toString(),
        ),
        infoDetail(
          kSpecial,
          (nak?.details?.special ?? '').toString(),
        ),
        infoDetail(
          kSummary,
          (nak?.details?.summary ?? '').toString(),
        ),
        infoDetail(
          kDeity,
          (nak?.details?.deity ?? '').toString(),
        ),
        infoDetail(
          kEndTime,
          ('${nak?.endTime?.hour ?? 0} hr ${nak?.endTime?.minute ?? 0} min ${nak?.endTime?.second ?? 0} sec')
              .toString(),
        ),
      ],
    );
  }

  Widget yogInfo(Yog? yog) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(kYog),
        infoDetail(
          '$kYog $kNumber',
          (yog?.details?.yogNumber ?? '').toString(),
        ),
        infoDetail(
          '$kYog $kName',
          (yog?.details?.yogName ?? '').toString(),
        ),
        infoDetail(
          kSpecial,
          (yog?.details?.special ?? '').toString(),
        ),
        infoDetail(
          kEndTime,
          ('${yog?.endTime?.hour ?? 0} hr ${yog?.endTime?.minute ?? 0} min ${yog?.endTime?.second ?? 0} sec')
              .toString(),
        ),
      ],
    );
  }

  Widget karanInfo(Karan? karan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(kKaran),
        infoDetail(
          '$kKaran $kNumber',
          (karan?.details?.karanNumber ?? '').toString(),
        ),
        infoDetail(
          '$kKaran $kName',
          (karan?.details?.karanName ?? '').toString(),
        ),
        infoDetail(
          kSpecial,
          (karan?.details?.special ?? '').toString(),
        ),
        infoDetail(
          kDeity,
          (karan?.details?.deity ?? '').toString(),
        ),
        infoDetail(
          kEndTime,
          ('${karan?.endTime?.hour ?? 0} hr ${karan?.endTime?.minute ?? 0} min ${karan?.endTime?.second ?? 0} sec')
              .toString(),
        ),
      ],
    );
  }

  Widget infoTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.text18Bold(),
    );
  }

  Widget infoDetail(String label, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .text13Black()
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              detail.trim(),
              style: Theme.of(context)
                  .textTheme
                  .text13Black()
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }

  Widget verticalDivider() {
    return const SizedBox(
      height: 20,
      child: VerticalDivider(
        thickness: 1,
        color: Colors.black,
      ),
    );
  }

  Widget sunriseTiming(String label, String timing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .text13Blue()
                .copyWith(fontWeight: FontWeight.w300),
          ),
          Text(
            timing,
            style: Theme.of(context)
                .textTheme
                .text16Black()
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
