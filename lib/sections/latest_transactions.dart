import 'package:fintech_dashboard_clone/Controller/DataController.dart';
import 'package:fintech_dashboard_clone/Controller/NavigationHandler.dart';
import 'package:fintech_dashboard_clone/data/mock_data.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:fintech_dashboard_clone/widgets/category_box.dart';
import 'package:fintech_dashboard_clone/widgets/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:fintech_dashboard_clone/models/enums/transaction_type.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class LatestTransactions extends StatefulWidget {
  final bool fromnavigation;
  const LatestTransactions({Key? key, this.fromnavigation = false})
      : super(key: key);

  @override
  State<LatestTransactions> createState() => _LatestTransactionsState();
}

class _LatestTransactionsState extends State<LatestTransactions> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<DataHandlerController>(context, listen: false).getUsers());
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      title: "Registered Users",
      suffix: TextButton(
        child: Text(
          "See all",
          style: TextStyle(
            color: Styles.defaultRedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          Provider.of<NavigationHandler>(context, listen: false)
              .updateIndex(index: 1);
        },
      ),
      children: [
        Expanded(
          child: Consumer<DataHandlerController>(
              builder: (context, datahandler, child) {
            return datahandler.isUserLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : datahandler.users.isEmpty
                    ? const Center(
                        child: Text('No users are registered yet!'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: datahandler.users.length,
                        itemBuilder: (context, index) {
                          var data = datahandler.users[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(data.image ?? ''),
                                          ),
                                          // Container(
                                          //   padding: const EdgeInsets.all(2),
                                          //   decoration: const BoxDecoration(
                                          //     shape: BoxShape.circle,
                                          //     color: Colors.white,
                                          //   ),
                                          //   child: Icon(
                                          //     TransactionTypeExtensions(
                                          //       data.transactionType,
                                          //     ).icon,
                                          //     size: 12,
                                          //     color: Colors.black,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          data.name ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data.phone_number ?? '',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Visibility(
                                  visible: !Responsive.isMobile(context),
                                  child: Expanded(
                                    child: Text(
                                      "ID: ${data.user_id}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          datahandler.checkIfPlannotExists(
                                                  endDate: data.endDate,
                                                  startDate: data.startDate)
                                              ? 'Registered'
                                              : 'Not Registered')),
                                ),
                              ],
                            ),
                          );
                        },
                      );
          }),
        ),
      ],
    );
  }
}
