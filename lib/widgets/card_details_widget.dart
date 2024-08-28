import 'package:fintech_dashboard_clone/models/card_details.dart';
import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:fintech_dashboard_clone/models/enums/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension StringExtensions on String {
  String get securedString {
    if (length > 4) {
      return "**** ${substring(length - 4)}";
    } else {
      return this;
    }
  }
}

class CardDetailsWidget extends StatelessWidget {
  final CardDetails cardDetails;

  const CardDetailsWidget({Key? key, required this.cardDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Styles.defaultLightWhiteColor,
        borderRadius: Styles.defaultBorderRadius,
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(cardDetails.cardType ?? '')),
          Row(
            children: [
              const Expanded(child: Icon(Icons.code)),
              Expanded(
                child: Text(
                  cardDetails.cardNumber.securedString,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
