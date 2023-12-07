import 'package:choosenumber/api/reservation.dart';
import 'package:choosenumber/constants.dart';
import 'package:choosenumber/controller/auth_controller.dart';
import 'package:choosenumber/model/numAvailable.dart';
import 'package:choosenumber/model/reservation.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/screens/tableScreen.dart';
import 'package:choosenumber/widgets/sundry_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {
  var process_create = false.obs;

  var clientFirstName = TextEditingController().obs;
  var clientMiddleName = TextEditingController().obs;
  var clientLastName = TextEditingController().obs;
  var clientAdress = TextEditingController().obs;
  var clientCurrentMobileNumber = TextEditingController().obs;
  var clientEmailAdress = TextEditingController().obs;
  var rccm = TextEditingController().obs;
  var idnat = TextEditingController().obs;
  var adressCompany = TextEditingController().obs;
  var numberPurpose = TextEditingController().obs;
  var iccid = TextEditingController().obs;
  var listAvailable = <NumAvailable>[].obs;
  var process_load_avail = false.obs;
  var search = TextEditingController().obs;
  var crieria = Rxn<String>();
  var category = Rxn<String>();
  var listChosen = <NumAvailable>[].obs;
  var reservasions = <Reservation>[].obs;

  create() async {
    process_create.value = true;
    print("inside");
    if (listChosen.value.length < 0) {
      print("if cond");
      popSnackError(
          title: "Error", message: "Please select at least one number");
      process_create.value = false;
      return;
    }
    print("after");
    var reserv = Reservation(
      adressCompany: adressCompany.value.text,
      category: "",
      clientAdress: clientAdress.value.text,
      clientCurrentMobileNumber: clientCurrentMobileNumber.value.text,
      clientEmailAdress: clientCurrentMobileNumber.value.text,
      clientFirstName: clientFirstName.value.text,
      clientLastName: clientFirstName.value.text,
      clientMiddleName: clientMiddleName.value.text,
      idnat: idnat.value.text,
      numberPurpose: numberPurpose.value.text,
      rccm: rccm.value.text,
      //iccid: iccid.value.text
    );
    print("obj");
    var json = reserv.toJson();
    json['numbers'] = await NumAvailable.numsToJson(listChosen.value);
    print("obj3");
    ReserVationApi.post(json).then((value) {
      print("then");
      process_create.value = false;
      popSnackSuccess(message: "Reservation added successfully!");
      clearFrom();
    }).onError((DioException error, stackTrace) {
      print("error");
      process_create.value = false;
      print("${error.response!.data}");
    }).whenComplete(() {
      process_create.value = false;
    });
  }

  getList() {
    ReserVationApi.getList(Get.find<AuthController>().user.value!.id!)
        .then((value) async {
      reservasions.value = await Reservation.reservation(value.data);
    }).onError((DioException error, stackTrace) {
      print(error.response!.data);
    }).whenComplete(() {});
  }

  findNumbers() {
    process_load_avail.value = true;
    if (crieria.value == criteriaList.first.text) {
      crieria.value = "free";
    } else if (crieria.value == criteriaList[1].text) {
      crieria.value = "prefix";
    } else {
      crieria.value = "suffix";
    }
    ReserVationApi.FindNumbers(
            crieria.value!, search.value.text, category.value)
        .then((value) async {
      process_load_avail.value = false;
      try {
        listAvailable.value = await NumAvailable.numsfromJson(value.data);
        Get.defaultDialog(
            title: "Results",
            content: listAvailable.value.isNotEmpty
                ? Text("Found ${listAvailable.value.length} numbers")
                : const Text("No data found"),
            onCancel: listAvailable.value.isEmpty ? null : () => Get.back(),
            onConfirm: listAvailable.value.isEmpty
                ? () {
                    Get.back();
                  }
                : () {
                    Get.back();
                    Get.to(() => const TableScreen());
                  },
            textConfirm: listAvailable.value.isEmpty ? "OK" : "Reserver",
            textCancel: "Cancel",
            confirmTextColor: primaryColor);
      } catch (ex) {
        print(ex);
      }
    }).onError((DioException error, stackTrace) {
      process_load_avail.value = false;
      print("${error.response!.data}");
    }).whenComplete(() {
      process_load_avail.value = false;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getList();
  }

  clearFrom() {
    clientFirstName.value.clear();
    clientMiddleName.value.clear();
    clientLastName.value.clear();
    clientAdress.value.clear();
    clientCurrentMobileNumber.value.clear();
    clientEmailAdress.value.clear();
    rccm.value.clear();
    idnat.value.clear();
    adressCompany.value.clear();
    numberPurpose.value.clear();
    iccid.value.clear();
  }
}
