import 'package:fintech_dashboard_clone/Controller/DataController.dart';
import 'package:fintech_dashboard_clone/Controller/NavigationHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/card_details.dart';
import '../models/enums/card_type.dart';
import '../responsive.dart';
import '../sections/expense_income_chart.dart';
import '../sections/latest_transactions.dart';
import '../sections/statics_by_category.dart';
import '../sections/your_cards_section.dart';
import '../styles/styles.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<DataHandlerController>(context, listen: false)
            .getCredentials());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Main Panel
        const Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ExpenseIncomeCharts(),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: LatestTransactions(),
              ),
            ],
          ),
        ),
        // Right Panel
        Visibility(
          visible: Responsive.isDesktop(context),
          child: Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: Styles.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<DataHandlerController>(
                      builder: (context, dataHandler, child) {
                    return CardsSection(
                      cardDetails: [
                        if (dataHandler.keysModel != null) ...{
                          CardDetails(
                              dataHandler.keysModel!.OPENAI_CHATGPT_TOKEN ?? '',
                              'AI Token'),
                          if (Provider.of<NavigationHandler>(context,
                                      listen: false)
                                  .selectedIndex !=
                              0) ...{
                            CardDetails(
                                dataHandler.keysModel!.PAYPAL_CLIENT_ID ?? '',
                                'Paypal ClientId'),
                            CardDetails(
                                dataHandler.keysModel!.PAYPAL_SECRET_ID ?? '',
                                'Paypal SecretId'),
                            CardDetails(
                                dataHandler.keysModel!.Stripe_Publishable_Key ??
                                    '',
                                'Stripe Publishable key'),
                            CardDetails(
                                dataHandler.keysModel!.Stripe_SECRET_Key ?? '',
                                'Stripe Secret key'),
                          }
                        } else ...{
                          CardDetails("not found...", 'Open AI Token'),
                          // CardDetails("not found...", 'Paypal Id'),
                          // CardDetails("not found...", 'Paypal Token'),
                        }
                      ],
                    );
                  }),
                  // const Expanded(
                  //   child: StaticsByCategory(),
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
