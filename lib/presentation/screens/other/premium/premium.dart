// ignore_for_file: avoid_print

import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/Logic/cubits/Home_cubit/homestate.dart';
import 'package:dating/Logic/cubits/premium_cubit/premium_bloc.dart';
import 'package:dating/Logic/cubits/premium_cubit/premium_state.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/premium/premium_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../Logic/paymentGateway/razorpayy.dart';
import '../../../../core/config.dart';
import '../../../../language/localization/app_localization.dart';
import '../../../../payment/flutterwave.dart';
import '../../../../payment/inputformater.dart';
import '../../../../payment/paymentcard.dart';
import '../../../../payment/paypal_screen.dart';
import '../../../../payment/paytm.dart';
import '../../../../payment/sengenpay.dart';
import '../../../../payment/stripweb.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});
  static const String premiumScreenRoute = "/premiumScreen";

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {


@override
  void initState() {
    super.initState();
    _razorPayClass.initiateRazorPay(
        handlePaymentError: handlePaymentError,
        handleExternalWallet: handleExternalWallet,
        handlePaymentSuccess: handlePaymentSuccess);
    BlocProvider.of<PremiumBloc>(context,listen: false).planDataApi(context).then((value) {
      BlocProvider.of<PremiumBloc>(context,listen: false).paymentGateway(context).then((value1) {
       BlocProvider.of<PremiumBloc>(context).completeApi(value.planData!, value1.paymentdata!);
      });
    });
  }

  late PremiumProvider premiumProvider;
  final RazorPayClass _razorPayClass = RazorPayClass();


void handlePaymentSuccess(PaymentSuccessResponse response) {

BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: response.paymentId.toString(), pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);

}

void handlePaymentError(PaymentFailureResponse response) {

  Fluttertoast.showToast(msg: "ERROR: ${response.code} - ${response.message!}", toastLength: Toast.LENGTH_SHORT);

}

void handleExternalWallet(ExternalWalletResponse response) {

  Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName!}", toastLength: Toast.LENGTH_SHORT

);

}
  @override
  Widget build(BuildContext context) {
    premiumProvider = Provider.of<PremiumProvider>(context);
    return Scaffold(

      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,leading: const BackButtons(),clipBehavior: Clip.none,
      ),

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar:  BlocBuilder<PremiumBloc,PremiumState>(
        builder: (context, state)  {
          if(state is PremiumComplete){
            return  BlocBuilder<HomePageCubit,HomePageStates>(builder: (context, state1) {
               if(state1 is HomeCompleteState){
                 return
                   // state1.homeData.planId == premiumProvider.selectedPlan.toString()? SizedBox() :
                 Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Row(
                     children: [
                       Expanded(child: MainButton(titleColor: state1.homeData.planId == premiumProvider.selectedPlan.toString()? AppColors.black : AppColors.white,bgColor: state1.homeData.planId == premiumProvider.selectedPlan.toString()? AppColors.borderColor : AppColors.appColor,title: "FROM ${Provider.of<HomeProvider>(context,listen: false).currency}${premiumProvider.selectedPlanPrice}",
                        onTap: () {
                         if(premiumProvider.selectedPlan > 0){
                           state1.homeData.planId == premiumProvider.selectedPlan.toString() ? null :
                           showModalBottomSheet(
                             context: context,
                             constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height-300),
                             isScrollControlled: true,
                             builder: (context) {
                               return ClipRRect(
                                 borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                 child: Scaffold(
                                   floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
                                   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                                   floatingActionButton:  Padding(
                                     padding: const EdgeInsets.all(12.0),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Expanded(child:
                                         MainButton(
                                           bgColor: AppColors.appColor,
                                           // title: "Continue".tr,onTap: () {
                                           title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",onTap: () {

                                           if(premiumProvider.selectedPayment == 1) {
                                             _razorPayClass.openCheckout(
                                                 name:   Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name.toString(),
                                                 number: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.mobile.toString(),
                                                 amount: premiumProvider.selectedPlanPrice.toString(),
                                                 key:    premiumProvider.selectedPaymentattributes.toString(),
                                             );
                                           }
                                           else if(premiumProvider.selectedPayment == 3) {
                                             List ids = premiumProvider.selectedPaymentattributes.toString().split(",");
                                             print('++++++++++ids:------$ids');
                                             paypalPayment(
                                               context: context,
                                               function: (e){
                                                 BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$e", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
                                               },
                                               amt: premiumProvider.selectedPlanPrice.toStringAsFixed(2),
                                               clientId: ids[0],
                                               secretKey: ids[1],
                                             );
                                           }
                                           else if(premiumProvider.selectedPayment == 4) {
                                             Navigator.pop(context);
                                             stripePayment();
                                           }
                                           else if(premiumProvider.selectedPayment == 6) {
                                             print("Hello PayStack");
                                             Navigator.pop(context);
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               // SnackBar(content: Text('Not Valid'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                               SnackBar(content: Text(AppLocalizations.of(context)?.translate("Not Valid") ?? "Not Valid"),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                             );
                                           }
                                           else if(premiumProvider.selectedPayment == 7) {
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => Flutterwave(
                                                 totalAmount: premiumProvider.selectedPlanPrice.toStringAsFixed(2),
                                                 email: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.email.toString(),
                                             ),)).then((otid) {
                                               if (otid != null) {
                                                 BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$otid", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
                                                 // Fluttertoast.showToast(msg: 'Payment Successfully'.tr,timeInSecForIosWeb: 4);
                                                 Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Payment Successfully") ?? "Payment Successfully",timeInSecForIosWeb: 4);
                                               } else {
                                                 Navigator.pop(context);
                                               }
                                             });
                                           }
                                           else if(premiumProvider.selectedPayment == 8) {
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => PayTmPayment(
                                                 totalAmount: premiumProvider.selectedPlanPrice.toStringAsFixed(2),
                                                 uid: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.email.toString()
                                             ),)).then((otid) {
                                               if (otid != null) {
                                                 BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$otid", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
                                                 // Fluttertoast.showToast(msg: 'Payment Successfully'.tr,timeInSecForIosWeb: 4);
                                                 Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Payment Successfully") ?? "Payment Successfully",timeInSecForIosWeb: 4);
                                               } else {
                                                 Navigator.pop(context);
                                               }
                                             });
                                           }
                                           else if(premiumProvider.selectedPayment == 10) {
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => SenangPay(
                                                 email: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.email.toString(),
                                                 totalAmount: premiumProvider.selectedPlanPrice.toStringAsFixed(2),
                                                 name: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name.toString(),
                                                 phon: Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.mobile.toString()),)
                                             )
                                                 .then((otid) {
                                               if (otid != null) {
                                                 BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$otid", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
                                               } else {
                                                 Navigator.pop(context);
                                               }
                                             });
                                           }
                                           else{
                                             Navigator.pop(context);
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               // SnackBar(content: Text('Not Valid'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                               SnackBar(content: Text(AppLocalizations.of(context)?.translate("Not Valid") ?? "Not Valid"),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                             );
                                           }

                                         },
                                         )),
                                       ],
                                     ),
                                   ),
                                   body: Consumer<PremiumProvider>(
                                     builder: (BuildContext context, value, Widget? child) {
                                       return ListView.separated(
                                           clipBehavior: Clip.none,
                                           padding:  const EdgeInsets.only(top: 10.0,bottom: 50,right: 10,left: 10),
                                           shrinkWrap: true,
                                           itemBuilder: (context, index) {
                                             return InkWell(
                                               onTap: () {
                                                 // premiumProvider.selectedPayment = index;
                                                 value.updateSelectPayment(int.parse(state.payment[index].id.toString()));
                                                 value.updateAttributes(state.payment[index].attributes.toString());
                                                 value.updatePaymentName(state.payment[index].title.toString());
                                               },
                                               child: Container(
                                                 padding: const EdgeInsets.all(12),
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(12),
                                                     border: Border.all(color:value.selectedPayment == int.parse(state.payment[index].id.toString()) ? AppColors.appColor : Theme.of(context).dividerTheme.color!)
                                                 ),
                                                 child: Row(
                                                   children: [
                                                     Container(
                                                         height: 60,
                                                         width: 60,
                                                         decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(12),
                                                             border: Border.all(color: Theme.of(context).dividerTheme.color!)
                                                         ),
                                                         child: Image.network("${Config.baseUrl}${state.payment[index].img}")),
                                                     const SizedBox(width: 10,),
                                                     Expanded(
                                                       flex: 10,
                                                       child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Text(state.payment[index].title.toString(),style: Theme.of(context).textTheme.bodyMedium!),
                                                           const SizedBox(height: 2,),
                                                           Text(state.payment[index].subtitle.toString(),style: Theme.of(context).textTheme.bodySmall!),
                                                         ],
                                                       ),
                                                     ),
                                                     const Spacer(flex: 1),
                                                     Radio(
                                                       activeColor: AppColors.appColor,
                                                       value: value.selectedPayment == int.parse(state.payment[index].id.toString()) ? true : false,
                                                       groupValue: true,
                                                       onChanged: (value1) {
                                                         value.updateSelectPayment(int.parse(state.payment[index].id.toString()));
                                                         value.updateAttributes(state.payment[index].attributes.toString());
                                                         value.updatePaymentName(state.payment[index].title.toString());
                                                       },
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             );
                                           }, separatorBuilder: (context, index) {
                                         return const SizedBox(height: 10,);
                                       }, itemCount: state.payment.length);
                                     },
                                   ),
                                 ),
                               );
                             },);
                         }else{
                           // Fluttertoast.showToast(msg: "Select Plan".tr);
                           Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Select Plan") ?? "Select Plan");
                         }


                           },))
                     ],
                   ),
                 );
               }else{
                 return const SizedBox();
               }
              }
            );
          }else{
            return const SizedBox();
          }

        }
      ),
      body: BlocConsumer<PremiumBloc,PremiumState>(
            listener: (context, state) {
              if(state is PremiumError){
                Fluttertoast.showToast(msg: state.error);
              }
            },
            builder: (context,state) {
              if(state is PremiumComplete){
                return BlocBuilder<HomePageCubit,HomePageStates>(builder: (context, state1) {
                  if(state1 is HomeCompleteState){
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                              clipBehavior: Clip.none,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return  state.planData[index].status == "1"?  Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    InkWell(
                                      onTap: () {

                                        if(int.parse(state1.homeData.planId.toString()) <= int.parse(state.planData[index].id.toString())){
                                          premiumProvider.updateSelectPlan(int.parse(state.planData[index].id!));
                                          premiumProvider.updateSelectPlanPrice(int.parse(state.planData[index].amt!));
                                        }

                                      },

                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color:  premiumProvider.selectedPlan == int.parse(state.planData[index].id!) ? AppColors.appColor : Theme.of(context).dividerTheme.color!,width:premiumProvider.selectedPlan == int.parse(state.planData[index].id!) ? 3 : 2)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(state.planData[index].description.toString(),style: Theme.of(context).textTheme.bodyMedium),
                                          ],
                                        ),
                                      ),

                                    ),

                                    Positioned(
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration: BoxDecoration(
                                            color: AppColors.appColor,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Text("${state.planData[index].title} - ${state.planData[index].dayLimit} Days",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ),

                                    state1.homeData.planId == state.planData[index].id ?
                                    Positioned(
                                      top: -10,
                                      right: 40,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration: BoxDecoration(
                                            color: AppColors.appColor,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        // child: Text("Active".tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 12),),
                                        child: Text(AppLocalizations.of(context)?.translate("Active") ?? "Active",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 12),),
                                      ),
                                    ) : const SizedBox(),

                                  ],
                                ) : const SizedBox();
                              },    separatorBuilder: (context, index) {
                                   return const SizedBox(height: 20,);
                          },      itemCount: state.planData.length),
                        ],
                      ),
                    );
                  }else{
                    return const SizedBox();
                  }
                },);
                }else{
                return Center(child: CircularProgressIndicator(color: AppColors.appColor));
              }
            }
          ),
    );
  }




//Strip code


final _formKey = GlobalKey<FormState>();
var numberController = TextEditingController();
final _paymentCard = PaymentCardCreated();
var _autoValidateMode = AutovalidateMode.disabled;

final _card = PaymentCardCreated();


stripePayment() {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Ink(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 45),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 85,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: const BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            // Text("Add Your payment information".tr,
                            Text(AppLocalizations.of(context)?.translate("Add Your payment information") ?? "Add Your payment information",
                                style:  TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 0.5)),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Form(
                              key: _formKey,
                              autovalidateMode: _autoValidateMode,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    style:  TextStyle(color: AppColors.white),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(19),
                                      CardNumberInputFormatter()
                                    ],
                                    controller: numberController,
                                    onSaved: (String? value) {
                                      _paymentCard.number =
                                          CardUtils.getCleanedNumber(value!);

                                      CardTypee cardType =
                                      CardUtils.getCardTypeFrmNumber(
                                          _paymentCard.number.toString());
                                      setState(() {
                                        _card.name = cardType.toString();
                                        _paymentCard.type = cardType;
                                      });
                                    },
                                    onChanged: (val) {
                                      CardTypee cardType =
                                      CardUtils.getCardTypeFrmNumber(val);
                                      setState(() {
                                        _card.name = cardType.toString();
                                        _paymentCard.type = cardType;
                                      });
                                    },
                                    validator: CardUtils.validateCardNum,
                                    decoration: InputDecoration(
                                      prefixIcon: SizedBox(
                                        height: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 6,
                                          ),
                                          child: CardUtils.getCardIcon(_paymentCard.type,),
                                        ),
                                      ),
                                      focusedErrorBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ),
                                      errorBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ),
                                      enabledBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ),
                                      focusedBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ),
                                      hintText:
                                      // "What number is written on card?".tr,
                                      AppLocalizations.of(context)?.translate("What number is written on card?") ?? "What number is written on card?",
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      labelStyle: const TextStyle(color: Colors.grey),
                                      // labelText: "Number".tr,
                                      labelText: AppLocalizations.of(context)?.translate("Number") ?? "Number",
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: TextFormField(
                                          style:  TextStyle(color: AppColors.white),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4),
                                          ],
                                          decoration: InputDecoration(
                                              prefixIcon: const SizedBox(
                                                height: 10,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 14),
                                                  child: Icon(Icons.credit_card,color: Color(0xff7D2AFF)),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              errorBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              enabledBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.4),
                                                ),
                                              ),
                                              focusedBorder:  OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                      Colors.grey.withOpacity(0.4))),
                                              // hintText: "Number behind the card".tr,
                                              hintText: AppLocalizations.of(context)?.translate("Number behind the card") ?? "Number behind the card",
                                              hintStyle:
                                              const TextStyle(color: Colors.grey),
                                              labelStyle:
                                              const TextStyle(color: Colors.grey),
                                              // labelText: 'CVV'.tr),
                                              labelText: AppLocalizations.of(context)?.translate("CVV") ?? "CVV"),
                                          validator: CardUtils.validateCVV,
                                          keyboardType: TextInputType.number,
                                          onSaved: (value) {
                                            _paymentCard.cvv = int.parse(value!);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                      Flexible(
                                        flex: 4,
                                        child: TextFormField(
                                          style:  TextStyle(color: AppColors.white),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(4),
                                            CardMonthInputFormatter()
                                          ],
                                          decoration: InputDecoration(
                                            prefixIcon: const SizedBox(
                                              height: 10,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.symmetric(
                                                    vertical: 14),
                                                child: Icon(Icons.calendar_month,color: Color(0xff7D2AFF)),
                                              ),
                                            ),
                                            errorBorder:  OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            enabledBorder:  OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.withOpacity(0.4),
                                              ),
                                            ),
                                            // hintText: 'MM/YY'.tr,
                                            hintText: AppLocalizations.of(context)?.translate("MM/YY") ?? "MM/YY",
                                            hintStyle:  const TextStyle(color: Colors.grey),
                                            labelStyle: const TextStyle(color: Colors.grey),
                                            // labelText: "Expiry Date".tr,
                                            labelText: AppLocalizations.of(context)?.translate("Expiry Date") ?? "Expiry Date",
                                          ),
                                          validator: CardUtils.validateDate,
                                          keyboardType: TextInputType.number,
                                          onSaved: (value) {
                                            List<int> expiryDate =
                                            CardUtils.getExpiryDate(value!);
                                            _paymentCard.month = expiryDate[0];
                                            _paymentCard.year = expiryDate[1];
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.055),
                                  Container(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: CupertinoButton(
                                        onPressed: () {
                                          _validateInputs();
                                        },
                                        color: const Color(0xff7D2AFF),
                                        child: Text(
                                          "Pay ${premiumProvider.selectedPlanPrice.toString()}",
                                          style:  const TextStyle(fontSize: 17.0,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.065),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    },
  );
}

void _validateInputs() {
  final FormState form = _formKey.currentState!;
  if (!form.validate()) {
    setState(() {
      _autoValidateMode =
          AutovalidateMode.always;
    });

    // Fluttertoast.showToast(msg: "Please fix the errors in red before submitting.".tr,timeInSecForIosWeb: 4);
    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please fix the errors in red before submitting.") ?? "Please fix the errors in red before submitting.",timeInSecForIosWeb: 4);
  } else {
    var username = Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name.toString();

    var email = Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.email.toString();
    _paymentCard.name = username;
    _paymentCard.email = email;
    _paymentCard.amount = premiumProvider.selectedPlanPrice.toString();
    form.save();

    // Get.to(() => StripePaymentWeb(paymentCard: _paymentCard))!.then((otid) {
    //   Navigator.pop(context);
    //   if (otid != null) {
    //     BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$otid", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
    //     // Book_Ticket( uid: widget.uid, bus_id: widget.bus_id,pick_id: widget.pick_id, dropId: widget.dropId, ticketPrice: widget.ticketPrice,trip_date: widget.trip_date,paymentId: "$otid",boardingCity: widget.boardingCity,dropCity: widget.dropCity,busPicktime: widget.busPicktime,busDroptime: widget.busDroptime,Difference_pick_drop: widget.differencePickDrop);
    //   }
    // });

    Navigator.push(context, MaterialPageRoute(builder: (context) => StripePaymentWeb(paymentCard: _paymentCard),)).then((otid) {
      Navigator.pop(context);
      if (otid != null) {
        BlocProvider.of<PremiumBloc>(context).planPurchase(planId: premiumProvider.selectedPlan.toString(), tranID: "$otid", pname: premiumProvider.selectedPaymentName, pMethodId: premiumProvider.selectedPayment.toString(), context: context);
        // Book_Ticket( uid: widget.uid, bus_id: widget.bus_id,pick_id: widget.pick_id, dropId: widget.dropId, ticketPrice: widget.ticketPrice,trip_date: widget.trip_date,paymentId: "$otid",boardingCity: widget.boardingCity,dropCity: widget.dropCity,busPicktime: widget.busPicktime,busDroptime: widget.busDroptime,Difference_pick_drop: widget.differencePickDrop);
      }
    });

    // Fluttertoast.showToast(msg: "Payment card is valid".tr,timeInSecForIosWeb: 4);
    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Payment card is valid") ?? "Payment card is valid",timeInSecForIosWeb: 4);
  }
}





}
