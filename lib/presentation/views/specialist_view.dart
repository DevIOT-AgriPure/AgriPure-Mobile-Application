import 'package:agripure_mobile/models/profile_model.dart';
import 'package:agripure_mobile/presentation/views/add_specialist_view.dart';
import 'package:agripure_mobile/services/profile_service.dart';
import 'package:agripure_mobile/services/specialist_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/specialist_model2.dart';
import '../../services/contact_service.dart';

class SpecialistView extends StatefulWidget {
  const SpecialistView({Key? key}) : super(key: key);

  @override
  State<SpecialistView> createState() => _SpecialistViewState();
}

class _SpecialistViewState extends State<SpecialistView> {
  
  Future<SharedPreferences>? _prefs;
  List<Profile>? specialistIds;
  List<Profile>? profiles;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    super.initState();
    initialize();
  }


  Future initialize() async {
    final pref = await _prefs;
    int? accountId = pref?.getInt('accountId');
    List<Profile> fetchedProfiles = await ContactService.getSpecialistIdsForFarmer(accountId!);
    setState(() {
      profiles = fetchedProfiles;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var response = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddSpecialistView()));

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
            Text(
              "Do you want to contact an expert?",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Search specialist",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
                        hintText: "Ingrese una categoria para su experto"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Specialist contacted: ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FutureBuilder<List<Profile>>(
  future: ContactService.getContactsFarmerById().then((contacts) => ContactService.getDataBySpecialistId(contacts)),
  builder: (context, AsyncSnapshot<List<Profile>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      List<Profile> profiles = snapshot.data ?? [];

      if (profiles.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "No plants selected",
              style: TextStyle(
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
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              var profile = profiles[index];

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
                            borderRadius: BorderRadius
                                .circular(15),
                            child: Image.network(
                              '${profile.imageUrl}',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,)
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          "${profile.name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  //var response = await Navigator.push(
                                  //  context,
                                  //  MaterialPageRoute(
                                  //    builder: (context) => PlantDetailView(profile: profile),
                                  //  ),
                                  //);

                                  //if (response == true) {
                                  //  setState(() {});
                                  //}
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    }
  },
)
          ],
        ),
      ),
    );
  }
}

