import '../../airba_pay_sdk.dart';
import '../data_holder.dart';


String getStrFromRes(String ru, String kz) {
  if (DataHolder.currentLang == AirbaPaySdkLang.kz.lang) {
    return kz;
  } else {
    return ru;
  }
}
