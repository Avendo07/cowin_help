import 'package:cowin_help/models/pin/session.dart';
import 'package:stacked/stacked.dart';

class CenterListViewModel extends BaseViewModel {

  int _totalSlots;
  int get slots => _totalSlots;

  int findTotalSlots(List<Session> sessions){
    List<int> slots = sessions.map((session) => session.availableCapacity).toList();
    int sum = slots.reduce((value, element) => value + element);
    _totalSlots = sum;
    return sum;
  }

  int findMinAge(List<Session> sessions){
    bool age18 = sessions.any((element) => element.minAge == 18);
    if(age18){
      return 18;
    }else{
      return 45;
    }
  }
}
