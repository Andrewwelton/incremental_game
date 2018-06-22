import '../models/company.dart';
import '../models/staff.dart';

class SetCompanyAction {
  final Company newCompany;

  SetCompanyAction(this.newCompany);

  @override
  String toString() {
      return 'newCompanyName: ${newCompany.companyName} newCompanyCeoName: ${newCompany.ceoName}';
    }
}

class ResetCompanyAction {}

class AddLinesOfCodeAction {
  final double linesToAdd;

  AddLinesOfCodeAction(this.linesToAdd);
}

class HireStaffAction {
  final Staff staffToHire;

  HireStaffAction(this.staffToHire);
}

class ReleaseProductAction {}