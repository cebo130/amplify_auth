import 'package:flutter/material.dart';

import '../widgets/profile_head.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> cebo = List<String>.generate(10, (index){
    return 'this is $index';
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('Siyathokoza Mbatha'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
            onPressed: (){},
          ),
        ),
        preferredSize: Size(37.0,37.0),
      ),
      body: Column(
        children: [
          SizedBox(height: 80,),
          profileHead(),
        ],
      ),
    );
  }

}
