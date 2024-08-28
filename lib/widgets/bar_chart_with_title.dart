import 'package:fintech_dashboard_clone/data/mock_data.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:fintech_dashboard_clone/widgets/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWithTitle extends StatelessWidget {
  final String title;
  final Color barColor;
  final double amount;
  final bool isLoading;
  final bool isCount;

  const BarChartWithTitle({
    Key? key,
    this.isCount = false,
    this.isLoading = false,
    required this.title,
    required this.amount,
    required this.barColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Styles.defaultBorderRadius,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(Styles.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 10),
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CurrencyText(
                      currency: isCount ? '' : "\$",
                      amount: amount,
                    ),
                    const SizedBox(width: 8),
                    // Text(
                    //   'on this week',
                    //   style: TextStyle(
                    //     color: Styles.defaultGreyColor,
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    CurrencyText(
                      currency: isCount ? '' : "\$",
                      amount: amount,
                    ),
                    const SizedBox(width: 8),
                    // Text(
                    //   'on this week',
                    //   style: TextStyle(
                    //     color: Styles.defaultGreyColor,
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                ),
          const SizedBox(
            height: 38,
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    // tool: Colors.grey,
                    getTooltipItem: (a, b, c, d) => null,
                  ),
                ),
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  // bottomTitles:const AxisTitles(

                  //     sideTitles: SideTitles(showTitles: false)), SideTitles(
                  //   rotateAngle: Responsive.isMobile(context) ? 45 : 0,
                  //   showTitles: true,
                  //   getTextStyles: (context, value) => TextStyle(
                  //     color: Styles.defaultLightGreyColor,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 12,
                  //   ),
                  //   getTitles: (double value) {
                  //     switch (value.toInt()) {
                  //       case 0:
                  //         return 'Mon';
                  //       case 1:
                  //         return 'Tue';
                  //       case 2:
                  //         return 'Wed';
                  //       case 3:
                  //         return 'Thu';
                  //       case 4:
                  //         return 'Fri';
                  //       case 5:
                  //         return 'Sat';
                  //       case 6:
                  //         return 'Sun';
                  //       default:
                  //         return '';
                  //     }
                  //   },
                  // ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: MockData.getBarChartitems(
                  barColor,
                  width: Responsive.isMobile(context) ? 10 : 25,
                ),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
