import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/specialist_model.dart';

class SpecialistDetailView extends StatefulWidget {
  final Specialist specialist;
  const SpecialistDetailView({Key? key, required this.specialist}) : super(key: key);

  @override
  State<SpecialistDetailView> createState() => _SpecialistDetailViewState(specialist);
}

class _SpecialistDetailViewState extends State<SpecialistDetailView> {
  final Specialist specialist;
  _SpecialistDetailViewState(this.specialist);

  bool _hasCallSupport = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.white, // Cambiar el color de la flecha de regreso a blanco
          ),
          title: Text('${specialist.name}', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 12,
                  ),

                  Text('${specialist.description}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Contact information:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 12,
                  ),

                  Text('Telephone number: ${specialist.telephone_number}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Whatsapp Number: ${specialist.whatsapp_number}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Email: ${specialist.contact_email}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ElevatedButton(
                            onPressed:  _hasCallSupport
                                ? () => setState(() {
                                        _launched = _makePhoneCall(specialist.whatsapp_number.toString());
                                  }) : null,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orange,
                            ),
                            //child: const Text("Make a call", style: TextStyle(fontSize: 18)),
                            child: _hasCallSupport
                                ? const Text('Make phone call', style: TextStyle(fontSize: 18))
                                : const Text('Calling not supported', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ElevatedButton(
                            onPressed: () async{
                              String? encodeQueryParameters(Map<String, String> params) {
                                return params.entries
                                    .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                    .join('&');
                              }
                              final Uri emailUri = Uri(
                                scheme: "mailto",
                                path: specialist.contact_email.toString(),
                                query: encodeQueryParameters(<String, String>{
                                  "subject": "I have a query respect my plant",
                                }),
                              );
                              if(await canLaunchUrl(emailUri)){
                                launchUrl(emailUri);
                              } else {
                                throw Exception("Couldn't launch $emailUri");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orange,
                            ),
                            child: const Text('Send Email', style: TextStyle(fontSize: 18))
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text('Extra information:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 26,
                  ),

                  ExpansionTile(
                    title: Text('Favorite plants:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${specialist.info_favorite_plants}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),


                  ExpansionTile(
                    title: Text('Certifications:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${specialist.info_certifications}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 26,
                  ),

                  ExpansionTile(
                    title: Text('Experience:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${specialist.info_experience}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 26,
                  ),

                ],
              ),
            ),
          ],
        )
    );
  }
}