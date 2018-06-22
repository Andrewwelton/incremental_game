import 'company_reducer.dart';
import '../models/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    company: companyReducer(state.company, action)
  );
}