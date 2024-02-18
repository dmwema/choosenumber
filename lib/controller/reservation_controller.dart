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
  var rerseveListChosen = <Reservation>[].obs;
  var reservasions = <Reservation>[].obs;
  var process_loads = false.obs;
  var process_add_creations = false.obs;

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
      //print("error");
      print("${error.response!.data}");
      process_create.value = false;
    }).whenComplete(() {
      process_create.value = false;
    });
  }

  getList() async {
    process_loads.value = true;
    ReserVationApi.getList(Get.find<AuthController>().user.value!.id!)
        .then((value) async {
      print(value);
      reservasions.value = await Reservation.reservation(value.data);
      process_loads.value = false;
    }).onError((DioException error, stackTrace) {
      process_loads.value = false;
      print(error.response!.data);
    }).whenComplete(() {
      process_loads.value = false;
    });
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

  addCreation() async {
    process_add_creations.value = true;

    var arr = <Map<String, dynamic>>[];
    rerseveListChosen.forEach((element) {
      Map<String, dynamic> tp = {
        "msisdn": element.msisdn,
        "iccid": element.iccid,
        "idRes": element.idRsv,
        "createdAt": DateTime.now().toIso8601String(),
        "status": 0
      };
      arr.add(tp);
    });
    ReserVationApi.postCreation(arr).then((value) {
      process_add_creations.value = false;
      Get.back();
      rerseveListChosen.value.clear();
      getList();
      popSnackSuccess(
          message: value.data['message'], duration: const Duration(seconds: 7));
      print("created");

      //Get.back();
    }).onError((DioException error, stackTrace) {
      popSnackError(message: "An error occurred");
      process_add_creations.value = false;
      print('${error.response!.data}');
    }).whenComplete(() => process_add_creations.value = false);
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
