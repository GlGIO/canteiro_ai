import 'package:canteiro_ai/module/layoutinfo/domain/params/addnewlayout_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/typedefs/layoutinfo_typedef.dart';

class AddNewLayoutUseCase {
  final LayoutInfoRepository repository;

  AddNewLayoutUseCase(this.repository);

  AddNewLayoutResult call(AddNewLayoutParams params) {
    return repository.addNewLayout(params);
  }
}
