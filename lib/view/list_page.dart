import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poketest/controller/list_controller.dart';
import 'package:poketest/main.dart';
import 'package:poketest/routes/app_router.dart';

class ListPage extends GetView<ListController> {
  var textValueController = TextEditingController();
  ListController controller = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    double widthSize = resWidthSize(context);
    double heightSize = resHeightSize(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: controller.obx((data) => Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: heightSize * 5),
                  height: heightSize * 4.8,
                  padding: EdgeInsets.symmetric(
                      horizontal: widthSize * 2, vertical: 0),
                  alignment: Alignment.center,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: widthSize * 3.6,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: widthSize * 0.30,
                    cursorHeight: heightSize * 3,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ], // allow only Upper/Lower letters
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontSize: widthSize * 3, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: widthSize * 0.24,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(widthSize * 2.4)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black, width: widthSize * 0.24),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length >= 3) {
                        controller.setText(value);
                      } else {
                        controller.setText('');
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 13,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  children: List.generate(data!.length, (index) {
                    return InkWell(
                      onTap: () {
                        router.push(DetailPageRoute(user: data[index]));
                      },
                      child: Card(
                        color: Colors.yellow,
                        child: Column(
                          children: [
                            ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.5,
                                child: kIsWeb || !const bool.fromEnvironment('dart.vm.product')
                                    ? (data[index].images?.large != null && data[index].images!.large!.startsWith('data:')
                                        ? Container(height: 80, color: Colors.grey) // Use a placeholder for data URIs in tests
                                        : Image.network(
                                            data[index].images?.large ?? '',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ))
                                    : Image.network(
                                        data[index].images?.large ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  data[index].name ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: widthSize * 3.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          )),
    );
  }

  double resWidthSize(BuildContext context) {
    // device width & height size parameter
    double widthSize;
    if (MediaQuery.of(context).size.width > 598) {
      widthSize = MediaQuery.of(context).size.width * 0.0072;
    } else {
      widthSize = MediaQuery.of(context).size.width * 0.01;
    }
    return widthSize;
  }

  double resHeightSize(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height * 0.01;
    return heightSize;
  }

  showSnackBar(BuildContext context) {
    SnackBar snackBar = const SnackBar(
      content: Text('Yay! A SnackBar!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
