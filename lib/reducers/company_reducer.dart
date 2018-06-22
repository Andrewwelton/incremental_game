import 'package:redux_persist/redux_persist.dart';

import '../models/app_state.dart';
import '../models/company.dart';
import '../models/staff.dart';
import '../actions/actions.dart';

Company companyReducer(Company state, dynamic action) {
  print(action.toString());

  if (action is PersistLoadedAction<AppState>) {
    return action.state.company;
  }

  if (action is SetCompanyAction) {
    return action.newCompany;
  }

  if (action is AddLinesOfCodeAction) {
    return state.copyWith(
      currentLinesOfCode: state.currentLinesOfCode += state.linesOfCodeProducedPerTick
    );
  }

  if (action is ReleaseProductAction) {
    return state.copyWith(
      companyCash: state.companyCash += state.currentLinesOfCode / 2,
      currentLinesOfCode: 0.0
    );
  }

  if (action is HireStaffAction) {
    List<Staff> newStaffList = state.currentStaff.take(900).toList() ?? new List();
    newStaffList.add(action.staffToHire);
    return state.copyWith(
      currentStaff: newStaffList,
      linesOfCodeProducedPerTick: state.linesOfCodeProducedPerTick += action.staffToHire.linesOfCodeProduced,
      companyCash: state.companyCash - action.staffToHire.cost
    );
  }

  if (action is ResetCompanyAction) {
    return new Company(companyName: '', ceoName: '', currentLinesOfCode: 0.0, linesOfCodeProducedPerTick: 5.0, companyCash: 1000.0);
  }

  return state;
}