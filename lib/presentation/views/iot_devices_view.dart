import 'package:agripure_mobile/presentation/views/device_catalog_view.dart';
import 'package:agripure_mobile/presentation/views/profile_view.dart';
import 'package:agripure_mobile/presentation/views/specialist_detail_view.dart';
import 'package:agripure_mobile/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:agripure_mobile/services/settings_service.dart';
import 'package:agripure_mobile/services/auth_service.dart';

import '../../services/specialist_service.dart';

class IoTDevicesView extends StatefulWidget {
  const IoTDevicesView({Key? key}) : super(key: key);

  @override
  State<IoTDevicesView> createState() => _IoTDevicesView();
}

class _IoTDevicesView extends State<IoTDevicesView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var response = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeviceCatalogView()));

            if(response == true) {
              setState(() {});
            }
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IoT Devices",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Text("Search device",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),

              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ingrese un dispositivo a buscar"
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              //Text("Specialist contacted: ",
              //  style: TextStyle(
              //    fontSize: 22,
              //    fontWeight: FontWeight.bold,
              //    color: Colors.white,
              //  ),),

              SizedBox(
                height: 15,
              ),

              FutureBuilder(
                  initialData: [],
                  future:  SpecilistService.getSpecilist(),
                  builder: (context, AsyncSnapshot<List> snapshot){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < snapshot.data!.length) {
                              var specialist = snapshot.data![index];

                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          /*ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image.network('${specialist.image}',
                                                width: double.infinity,
                                                height: 200,
                                                fit: BoxFit.cover,)
                                          ),

                                          SizedBox(
                                            height:  10,
                                          ),*/

                                          Text("${specialist.name}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold
                                          ),),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => SpecialistDetailView(specialist: specialist)
                                                    ));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.orange, // Establecer el fondo anaranjado
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Text("Details", style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )

                                        ],
                                      ),
                                    )
                                ),
                              );
                            } /*else {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4D4D4D),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'NOT AVAILABLE SPECIALISTS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }*/


                          }),
                    );
                  }
              )
            ],
          ),

        )
    );
  }
}