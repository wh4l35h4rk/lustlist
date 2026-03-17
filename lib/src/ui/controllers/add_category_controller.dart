import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import '../notifiers/list_notifier.dart';

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

  void toggleSelected(EOption option) {
    if  (selectedOptions.value.contains(option)){
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }
}