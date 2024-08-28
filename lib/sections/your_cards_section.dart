import 'package:fintech_dashboard_clone/Controller/NavigationHandler.dart';
import 'package:fintech_dashboard_clone/models/card_details.dart';
import 'package:fintech_dashboard_clone/widgets/card_details_widget.dart';
import 'package:fintech_dashboard_clone/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsSection extends StatelessWidget {
  final List<CardDetails> cardDetails;

  const CardsSection({Key? key, required this.cardDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      title: "Your Credentials",
      suffix: TextButton(
          onPressed: () {
            Provider.of<NavigationHandler>(context, listen: false)
                .updateIndex(index: 2);
          },
          child: const Text('View All')),
      children: cardDetails
          .map(
            (CardDetails details) => CardDetailsWidget(cardDetails: details),
          )
          .toList(),
    );
  }
}
