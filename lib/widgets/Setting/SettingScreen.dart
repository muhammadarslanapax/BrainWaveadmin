import 'package:fintech_dashboard_clone/Controller/DataController.dart';
import 'package:fintech_dashboard_clone/models/KeysModel.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:fintech_dashboard_clone/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  final TextEditingController openApiToken = TextEditingController();
  final TextEditingController addUnitId = TextEditingController();
  final TextEditingController iosAddUnitId = TextEditingController();

  final TextEditingController adRewardedUnitId = TextEditingController();
  final TextEditingController iosAdRewardedUnitId = TextEditingController();
  final TextEditingController nativeAddUnitId = TextEditingController();
  final TextEditingController iosNativeAddUnitId = TextEditingController();
  final TextEditingController adIntersialUnitId = TextEditingController();
  final TextEditingController iosAdIntersialUnitId = TextEditingController();

  final TextEditingController paypalClientId = TextEditingController();

  final TextEditingController paypalSecretId = TextEditingController();

  final TextEditingController stripePublishablekey = TextEditingController();

  final TextEditingController stripeSecretkey = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataHandler = Provider.of<DataHandlerController>(context, listen: false);
    if (dataHandler.keysModel != null) {
      getCredentials();
    } else {
      setControllerValues();
    }
    setIds();
    _tabController = TabController(
        length: 2, vsync: this); // Change the length as per your number of tabs
  }

  getCredentials() async {
    await dataHandler.getCredentials();
    setControllerValues();
  }

  late DataHandlerController dataHandler;
  setControllerValues() {
    if (dataHandler.keysModel != null) {
      openApiToken.text = dataHandler.keysModel!.OPENAI_CHATGPT_TOKEN ?? '';
      adIntersialUnitId.text = dataHandler.keysModel!.adIntersialUnitId ?? '';
      iosAdIntersialUnitId.text =
          dataHandler.keysModel!.iosAdIntersialUnitId ?? '';
      addUnitId.text = dataHandler.keysModel!.bannerAddID_android ?? '';
      iosAddUnitId.text = dataHandler.keysModel!.iosBannerAddId ?? '';
      iosAdRewardedUnitId.text =
          dataHandler.keysModel!.iosAdRewardedUnitId ?? '';
      adRewardedUnitId.text = dataHandler.keysModel!.adRewardedUnitId ?? '';
      nativeAddUnitId.text = dataHandler.keysModel!.nativeAddUnitId ?? '';
      iosNativeAddUnitId.text = dataHandler.keysModel!.iosNativeAddUnitId ?? '';
      paypalClientId.text = dataHandler.keysModel!.PAYPAL_CLIENT_ID ?? '';
      paypalSecretId.text = dataHandler.keysModel!.PAYPAL_SECRET_ID ?? '';
      stripePublishablekey.text =
          dataHandler.keysModel!.Stripe_Publishable_Key ?? '';
      stripeSecretkey.text = dataHandler.keysModel!.Stripe_SECRET_Key ?? '';
    }
  }

  setIds() async {}

  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataHandlerController>(
        builder: (context, dataHandler, child) {
      return CategoryBox(
        suffix: dataHandler.isUserLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    // dataHandler.keysModel ??= KeysModel();
                    KeysModel keysModel = KeysModel(
                        adIntersialUnitId: adIntersialUnitId.text,
                        adRewardedUnitId: adRewardedUnitId.text,
                        bannerAddID_android: addUnitId.text,
                        iosBannerAddId: iosAddUnitId.text,
                        iosAdIntersialUnitId: iosAdIntersialUnitId.text,
                        iosAdRewardedUnitId: iosAdRewardedUnitId.text,
                        iosNativeAddUnitId: iosNativeAddUnitId.text,
                        nativeAddUnitId: nativeAddUnitId.text,
                        OPENAI_CHATGPT_TOKEN: openApiToken.text,
                        PAYPAL_CLIENT_ID: paypalClientId.text,
                        PAYPAL_SECRET_ID: paypalSecretId.text,
                        Stripe_Publishable_Key: stripePublishablekey.text,
                        Stripe_SECRET_Key: stripeSecretkey.text);
                    Provider.of<DataHandlerController>(context, listen: false)
                        .updateCredentials(keyModel: keysModel);
                  }
                },
                child: const Text('Update')),
        title: 'Credentials',
        isToShow: true,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Paypal/Stripe/OpenAI'),
              Tab(text: 'AddMob'),
              // Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
          Expanded(
              child: Form(
            key: formkey,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    getTextWidget(title: 'Open Ai Settings:'),
                    customTextField(
                        controller: openApiToken,
                        context: context,
                        hintText: 'Open Api Token'),
                    getTextWidget(title: 'PayPal Settings:'),
                    customTextField(
                        controller: paypalClientId,
                        context: context,
                        hintText: 'Paypal ClientId'),
                    customTextField(
                        controller: paypalSecretId,
                        context: context,
                        hintText: 'Paypal SecretId'),
                    getTextWidget(title: 'Stripe Settings:'),
                    customTextField(
                        controller: stripePublishablekey,
                        context: context,
                        hintText: 'Stripe Publishable key'),
                    customTextField(
                        controller: stripeSecretkey,
                        context: context,
                        hintText: 'Stripe Secret key'),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                ListView(
                  children: [
                    getTextWidget(title: 'AdMob Ids'),
                    customTextField(
                        controller: addUnitId,
                        context: context,
                        hintText: 'Android app Banner Id'),
                    customTextField(
                        controller: iosAddUnitId,
                        context: context,
                        hintText: 'IOS banner Id'),
                    customTextField(
                        controller: adRewardedUnitId,
                        context: context,
                        hintText: 'Android app Reward Id'),
                    customTextField(
                        controller: iosAdRewardedUnitId,
                        context: context,
                        hintText: 'IOS app Reward Id'),
                    customTextField(
                        controller: adIntersialUnitId,
                        context: context,
                        hintText: 'Android app Insertial Id'),
                    customTextField(
                        controller: iosAdIntersialUnitId,
                        context: context,
                        hintText: 'IOS app insertial Id'),
                    customTextField(
                        controller: nativeAddUnitId,
                        context: context,
                        hintText: 'Android app Native Id'),
                    customTextField(
                        controller: iosNativeAddUnitId,
                        context: context,
                        hintText: 'IOS app Native Id'),
                  ],
                )
              ],
            ),
          ))
        ],
        // child: const Column(
        //   children: [],
        // ),
      );
    });
  }
}

getTextWidget({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 23),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
  );
}

Widget customTextField(
    {String? hintText,
    required TextEditingController controller,
    double? width,
    required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
    width: Responsive.isMobile(context)
        ? null
        : MediaQuery.of(context).size.width * 0.4,
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == '' || value == null) {
          return 'Please enter $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
  );
}
