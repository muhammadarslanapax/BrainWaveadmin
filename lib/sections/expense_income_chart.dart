import 'package:fintech_dashboard_clone/Controller/DataController.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:fintech_dashboard_clone/widgets/bar_chart_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ExpenseIncomeCharts extends StatefulWidget {
  const ExpenseIncomeCharts({Key? key}) : super(key: key);

  @override
  State<ExpenseIncomeCharts> createState() => _ExpenseIncomeChartsState();
}

class _ExpenseIncomeChartsState extends State<ExpenseIncomeCharts> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataHandlerController>(
        builder: (context, datahandler, child) {
      return Row(
        children: [
          Flexible(
            child: BarChartWithTitle(
              title: "Total Users",
              isCount: true,
              amount: datahandler.users.length.toDouble(),
              isLoading: datahandler.isUserLoading,
              barColor: Styles.defaultBlueColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: BarChartWithTitle(
              title: "Premium Users",
              isLoading: datahandler.isUserLoading,
              amount: datahandler.users
                  .where((element) => datahandler.checkIfPlannotExists(
                      endDate: element.endDate, startDate: element.startDate))
                  .toList()
                  .length
                  .toDouble(),
              isCount: true,
              barColor: Styles.defaultRedColor,
            ),
          ),
        ],
      );
    });
  }
}
