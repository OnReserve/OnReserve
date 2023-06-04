import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/qr_controller.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  QRController qrController = Get.find<QRController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;

  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //     print("CHECKED  ${scanData.code}");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // controller?.resumeCamera();
  }

  @override
  void reassemble() {
    super.reassemble();

    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // } else if (Platform.isIOS) {
    //   controller!.resumeCamera();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // handle menu item selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'menu_item_1',
                child: Text('Sort by Price'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_2',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_3',
                child: Text('Filter by Category'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        centerTitle: true,
        title: SafeArea(
          child: Text("Payment Options",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 65.sp,
                  fontFamily: "Inter")),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child:
                // QRView(
                //   key: qrKey,
                //   onQRViewCreated: onQRViewCreated,
                // ),
                SizedBox(),
          ),
          GetBuilder<QRController>(builder: (qrController) {
            return Expanded(
              flex: 1,
              child: Center(
                child
                    // : (result != null)
                    //     ? Text(
                    //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : Text('Scan a code'),
              ),
            );
          })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
