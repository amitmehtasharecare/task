import 'package:get/get.dart';
import 'package:poketest/services/api_services.dart';

class ListController extends GetxController with StateMixin<List<dynamic>> {
  var text = "".obs;

  List filteredList = RxList(); // Rx List
  List userList = []; // get User List from API

  get getText => text.value;
  void setText(String query) {
    text.value = query;
  }

  void filterList() {
    // filter the List (by name or lastName)
    final filtered = userList
        .where((item) =>
                (item.name.toLowerCase().contains(text.value.toLowerCase()))
            //  ||
            // (item.lastName.toLowerCase().contains(_text.value.toLowerCase()))
            )
        .toList();

    filteredList.assignAll(filtered); // Filtered List
    print('Search performed: ${text.value}'); // Debugging output
    // use debounce 
    change(filteredList, status: RxStatus.success()); // update List
  }

  @override
  void onInit() {
    super.onInit();

    ApiServices().getUser().then((value) {
      Get.snackbar('Success', 'User list fetched successfully');
      userList = value;
      change(userList, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });

    ever(text, (_) => filterList()); // listen Search box and filtering
  }

  void onDataReceived(users) {
    Get.snackbar(
      'Success',
      'Data loaded successfully',
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // For testing: allow setting state from test
  void setTestState(List<dynamic> data) {
    change(data, status: RxStatus.success());
  }
}
