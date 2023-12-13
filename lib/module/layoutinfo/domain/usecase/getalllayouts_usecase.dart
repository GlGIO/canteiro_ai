import 'package:canteiro_ai/module/layoutinfo/domain/params/getalllayouts_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/typedefs/layoutinfo_typedef.dart';

class GetAllLayoutsUseCase {
  final LayoutInfoRepository repository;

  GetAllLayoutsUseCase(this.repository);

  GetAllLayoutsResult call(GetAllLayoutsParams params) {
    return repository.getAllLayouts(params);
  }
}
