import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/Logic/cubits/Home_cubit/homestate.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui.dart';
import '../../../../language/localization/app_localization.dart';

class PlanDetils extends StatefulWidget {
  static const String planRoutes = "/planDetils";
  const PlanDetils({Key? key}) : super(key: key);

  @override
  State<PlanDetils> createState() => _PlanDetilsState();
}

class _PlanDetilsState extends State<PlanDetils> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              // child: MainButton(title: "Upgrade".tr,onTap: () {
              child: MainButton(title: AppLocalizations.of(context)?.translate("Upgrade") ?? "Upgrade",onTap: () {
                Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
              },),
            ),
          ],
        ),
      ),
      body:

      BlocBuilder<HomePageCubit,HomePageStates>(
        builder: (context, state){
           if(state is HomeCompleteState){
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        BackButtons(),
                      ]),
                      const SizedBox(height: 10,),
                      // Text("You're Activated Membership!".tr,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
                      Text(AppLocalizations.of(context)?.translate("You're Activated Membership!") ?? "You're Activated Membership!",style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
                      const SizedBox(height: 15,),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.appColor ,width:  3)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.homeData.plandata!.planDescription.toString(),style: Theme.of(context).textTheme.bodyMedium),
                              ],
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
                              child: Text(state.homeData.plandata!.planTitle.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
                            ),
                          ),
                
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                          children: [
                        // Text("Payment method".tr,style: Theme.of(context).textTheme.bodySmall),
                        Text(AppLocalizations.of(context)?.translate("Payment method") ?? "Payment method",style: Theme.of(context).textTheme.bodySmall),
                        const Spacer(),
                        Text(state.homeData.plandata!.pName.toString(),style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                      const SizedBox(height: 10,),
                      Row(
                          children: [
                            // Text("transaction id".tr,style: Theme.of(context).textTheme.bodySmall),
                            Text(AppLocalizations.of(context)?.translate("transaction id") ?? "transaction id",style: Theme.of(context).textTheme.bodySmall),
                            const Spacer(),
                            Text(state.homeData.plandata!.transId.toString(),style: Theme.of(context).textTheme.bodyMedium),
                          ]),
                      Divider(height: 20,color: Theme.of(context).dividerTheme.color!,),
                      Row(
                          children: [
                            // Text("Date of Purchase".tr,style: Theme.of(context).textTheme.bodySmall),
                            Text(AppLocalizations.of(context)?.translate("Date of Purchase") ?? "Date of Purchase",style: Theme.of(context).textTheme.bodySmall),
                            const Spacer(),
                            Text(state.homeData.plandata!.planStartDate.toString().split(' ').first,style: Theme.of(context).textTheme.bodyMedium),
                          ]),
                      const SizedBox(height: 10,),
                      Row(
                          children: [
                            // Text("Date of Expiry".tr,style: Theme.of(context).textTheme.bodySmall),
                            Text(AppLocalizations.of(context)?.translate("Date of Expiry") ?? "Date of Expiry",style: Theme.of(context).textTheme.bodySmall),
                            const Spacer(),
                            Text(state.homeData.plandata!.planEndDate.toString().split(' ').first,style: Theme.of(context).textTheme.bodyMedium),
                          ]),
                      Divider(height: 20,color: Theme.of(context).dividerTheme.color!,),
                      Row(
                          children: [
                            // Text("Membership Amount".tr,style: Theme.of(context).textTheme.bodySmall),
                            Text(AppLocalizations.of(context)?.translate("Membership Amount") ?? "Membership Amount",style: Theme.of(context).textTheme.bodySmall),
                            const Spacer(),
                            Text( "${Provider.of<HomeProvider>(context,listen: false).currency}${state.homeData.plandata!.amount.toString()}",style: Theme.of(context).textTheme.bodyMedium),
                          ]),
                
                    ],
                  ),
                ),
              ),
            );
          }else{
             return Center(child: CircularProgressIndicator(color: AppColors.appColor));
           }

        }
      )

    );
  }
}
