import 'package:choosenumber/controller/reservation_controller.dart';
import 'package:choosenumber/model/numAvailable.dart';
import 'package:choosenumber/model/reservation.dart';
import 'package:choosenumber/res/colors.dart';
import 'package:choosenumber/screens/creationScreen.dart';
import 'package:choosenumber/screens/reservationScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  var resController = Get.put(ReservationController());
  final _numSeleced = <Reservation>[];
  var searchController = TextEditingController();
  List<Reservation> filteredData = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resController.getList();

    filteredData = resController.reservasions;
    print(filteredData.length);
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = (text.isEmpty
          ? resController.reservasions
          : resController.reservasions
              .where((item) =>
                  item.msisdn!.toLowerCase().contains(text.toLowerCase()) ||
                  item.clientFirstName!
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.clientLastName!
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.rccm!.toLowerCase().contains(text.toLowerCase()) ||
                  item.idnat!.toLowerCase().contains(text.toLowerCase()))
              .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    print("filterdata: ${filteredData.length}");
    print("recon: ${resController.reservasions.value.length}");
    return Scaffold(
      backgroundColor: primaryColor,
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          print("pressed");
          //Get.to(() => const SaleScreen());
          //Get.to(()=>const AgentsScreen());
        },
      ),*/
      appBar: AppBar(
        title: const Text("Reservations",
            style: TextStyle(
              color: primaryWhite,
              fontFamily: 'Segoe UI',
              fontSize: 30,
              shadows: [
                Shadow(
                  color: Color(0xba000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            )),
        //centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: primaryWhite),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Obx(() {
          //print(saleController.solds.value.length);
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
                //controller: controller,
                child: Container(
                    child: resController.process_loads.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        : resController.reservasions.isEmpty
                            ? const Center(
                                child: Text(
                                'No Number found!!',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff000000),
                                ),
                                textAlign: TextAlign.left,
                              ))
                            : Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                      hintText: 'Search...',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    onChanged: _onSearchTextChanged,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 5, right: 5),
                                  child: PaginatedDataTable(
                                      header: const Text("Reservations"),
                                      arrowHeadColor: primaryColor,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              resController.rerseveListChosen
                                                  .value = _numSeleced;
                                              Get.to(
                                                  () => const CreationScreen());
                                            },
                                            child: const Text("Confirm"))
                                      ],
                                      showFirstLastButtons: true,
                                      rowsPerPage: filteredData.length < 10
                                          ? filteredData.length
                                          : 10,
                                      columnSpacing: 20,
                                      showCheckboxColumn: true,
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'MSISDN',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Client Name',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'National ID',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Status',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ],
                                      source: TableRow(filteredData,
                                          (Reservation value) {
                                        _numSeleced.removeWhere((element) =>
                                            element.msisdn == value.msisdn);
                                        if (value.selected!) {
                                          _numSeleced.add(value);
                                        }

                                        print(_numSeleced.length);
                                      })),
                                ),
                              ]))),
          );
        }),
      ),
    );
  }
}

class TableRow extends DataTableSource {
  //var resController = Get.find<ReservationController>();
  int _selectedCount = 0;
  final List<Reservation> _nums;
  final Function onRowSelected;
  TableRow(this._nums, this.onRowSelected);
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _nums.length) return null;
    final Reservation num = _nums[index];
    return DataRow.byIndex(
        index: index,
        selected: num.selected!,
        onSelectChanged: (bool? value) {
          print(value);
          if (num.selected != value) {
            _selectedCount += value! ? 1 : -1;
            print(_selectedCount);
            //assert(_selectedCount >= 0);
            num.selected = value;
            notifyListeners();
            onRowSelected(num);
            //print('selected rows: $selectedRowCount');
          }
        },
        cells: [
          DataCell(Text(" ${num.msisdn}")),
          DataCell(Text("${num.clientFirstName}")),
          DataCell(Text("${num.idnat}")),
          DataCell(Text("${num.statusReservation}")),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _nums.length;

  @override
  int get selectedRowCount => 0;
}
