
import 'package:nb_utils/nb_utils.dart';

import 'constants.dart';

Stream<int> watchCountNotify() async* {
  while (true) {
    var value = getIntAsync(AppConstant.NOTI_COUNT);
    yield value;
    await Future.delayed(const Duration(seconds: 1));
  }
}