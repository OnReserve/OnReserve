import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_reserve/Controllers/ticket_controller.dart';

class BookingDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TicketController>();

    DateTime parsedDate1 = DateTime.parse(controller.args['createdAt']);
    DateTime parsedDate2 = DateTime.parse(controller.args['createdAt']);
    String formattedDate1 = DateFormat('MMMM d, yyyy').format(parsedDate1);
    String formattedDate2 = DateFormat('MMMM d, yyyy').format(parsedDate2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 20, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Center(
          child: Card(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            elevation: 8.0,
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SizedBox()),
                        Text(
                          formattedDate1,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      controller.args['event']['title'],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                      child: Text(
                        controller.args['event']['desc'],
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: DataTable(
                        dataRowColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.1)),
                        dataRowHeight: 30,
                        headingRowHeight: 30,
                        columns: [
                          DataColumn(
                              label: Text('Customers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey))),
                          DataColumn(
                              label: Text('Date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey))),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                                "${controller.args['economyCount'] + controller.args['vipCount']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                            DataCell(Text(formattedDate2.split(',')[0],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      child: DataTable(
                        dataRowColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.1)),
                        dataRowHeight: 30,
                        headingRowHeight: 30,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Ticket No.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Class',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('1232a.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                            DataCell(Text(
                                "${controller.args['economyCount']} ECO, ${controller.args['vipCount']} VIP",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Status
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Status : ',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withAlpha(200),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: !controller.args['approved']
                                  ? Colors.red.withOpacity(0.15)
                                  : Colors.green.withOpacity(0.15),
                            ),
                            child: Text(
                              controller.args['approved']
                                  ? 'Verified'
                                  : 'Pending',
                              style: TextStyle(
                                color: !controller.args['approved']
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),

                    DottedLine(
                      dashColor: Colors.grey,
                      lineThickness: 1.0,
                      dashGapLength: 8.0,
                      dashRadius: 8.0,
                      dashLength: 8.0,
                    ),
                    Center(
                      child: Image.network(
                        controller.args['qrcode'],
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Center(
                      child: Text(
                        controller.args['bookingToken'],
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
