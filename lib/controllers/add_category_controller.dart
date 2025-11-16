import '../database.dart';
import '../test_status.dart';
import 'list_notifier.dart';

class AddCategoryController {
  final ListNotifier<EOption> selectedOptions = ListNotifier<EOption>();
  final Map<EOption, TestStatus> statusMap = {};

  AddCategoryController({
    List<EOption>? selectedOptionsList,
    Map<EOption, TestStatus>? statusMap,
  }) {
    selectedOptions.value = selectedOptionsList ?? [];
    if (statusMap != null) {
      this.statusMap.addAll(statusMap); 
    }
  }

  List<EOption> getSelectedOptions() => selectedOptions.value;

  void setStatus(EOption option, TestStatus status) {
    statusMap[option] = status;
  }
}