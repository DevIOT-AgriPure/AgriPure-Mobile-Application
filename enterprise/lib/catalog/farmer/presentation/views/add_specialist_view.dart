
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../specialist/infraestructure/repositories/specialist_service.dart';

class AddSpecialistView extends StatefulWidget {
  const AddSpecialistView({super.key});

  @override
  State<AddSpecialistView> createState() => _AddSpecialistViewState();
}

class _AddSpecialistViewState extends State<AddSpecialistView> {

  bool _isLoading = false;
  String searchText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 4,
          iconTheme: IconThemeData(
          color: Colors.white,
          ),
          title: Text('Add specialist', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("Search specialists",
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
                        hintText: "Search a specialist"
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

              FutureBuilder(
                initialData: [],
                future:  SpecialistService.getAllSpecialists(),
                builder: (context, AsyncSnapshot<List> snapshot){
                  List filteredSpecialist = snapshot.data!.where((specialist) =>
                      specialist.name.toLowerCase().contains(searchText.toLowerCase())).toList();
                  if (snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("All specialist selected", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  } else {
                    if (filteredSpecialist.isEmpty) {
                      return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Text("Specialist not found", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            ),
                          ),
                        );
                    } else {
                      return Expanded(
                      child: ListView.builder(
                          itemCount: filteredSpecialist.length,
                          itemBuilder: (context, index) {
                            var specialist = filteredSpecialist[index];

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
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                15),
                                            child: Image.network(
                                              '${specialist.imageUrl}',
                                              width: double.infinity,
                                              height: 200,
                                              fit: BoxFit.cover,)
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Text("${specialist.name}", style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold
                                        ),),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });

                                                  //PlantService.savePlant(
                                                  //    plant.id).then((value) =>
                                                  //    Navigator.pop(
                                                  //        context, true)
                                                  //).catchError((error) {
                                                  //  String errorMessage = "Ocurrió un error durante el inicio de sesión";
                                                  //  errorMessage =
                                                  //      error.toString();
                                                  //  Fluttertoast.showToast(
                                                  //      msg: errorMessage,
                                                  //      toastLength: Toast
                                                  //          .LENGTH_SHORT,
                                                  //      backgroundColor: const Color
                                                  //          .fromRGBO(
                                                  //          255, 174, 0, 1.0),
                                                  //      textColor: Colors.black,
                                                  //      fontSize: 18.0
                                                  //  );
                                                  //}).whenComplete(() {
                                                  //  setState(() {
                                                  //    _isLoading = false;
                                                  //  });
                                                  //});
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .orange,
                                                ),
                                                child: _isLoading
                                                    ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: const CircularProgressIndicator(
                                                      valueColor: AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                      strokeWidth: 3.0,
                                                    )
                                                ) : const Padding(
                                                  padding: EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    "Add", style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold
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
                          }),
                    );
                    }
                  }
                }
            )
            

            
            ],
            ),
        ),
    );
  }
}