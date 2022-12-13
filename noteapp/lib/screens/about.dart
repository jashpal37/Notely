import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';


class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Colors.teal,
        body: ContactUs(
          email: 'jashpalsinhparmar422@gmail.com',

          companyName: 'Contact Us',
          phoneNumber: '+919773105362',
          dividerThickness: 2,
          githubUserName: 'jashpal37',
          linkedinURL: 'https://www.linkedin.com/in/jashpalsinh-parmar-132514204',
          tagLine: '', cardColor: Colors.white, companyColor: Colors.white, textColor: Colors.black, taglineColor: Colors.black,
        ),

        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Gautam Rathod & Jashpalsinh Parmar',
          textColor: Colors.white,
          backgroundColor: Colors.teal.shade300,
          email: 'gautamrathod70502@gmail.com',
        ),


      ),
    );
  }
}