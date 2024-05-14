import 'package:dating/data/models/paymentmodel.dart';

import '../../../data/models/premiummodel.dart';

class PremiumState{}
class PremiumInit extends PremiumState {}

class PremiumError  extends PremiumState{
  String error;
  PremiumError(this.error);
}

class PremiumComplete extends PremiumState{
  List<PlanDatum> planData;
  List<Paymentdatum> payment;
  PremiumComplete(this.planData,this.payment);
}