import 'package:flutter/material.dart';
String bio = 'it to make a type specimen book. It has survived not only five centuries';
Widget profileHead(){
  return Stack(
    children: [
      Stack(
        children: [Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20),),
            border: Border.all(color: Colors.indigo)
          ),
          child: Column(
            children: [
              // Divider(
              //   // indent: 70,
              //   // endIndent: 70,
              //   color: Colors.blueGrey,
              // ),
              SizedBox(height: 30,),
              Text('Siyathokoza Mbatha',style: TextStyle(color: Colors.teal,fontSize: 25),),
              Divider(
                indent: 140,
                endIndent: 140,
                color: Colors.blueGrey,
              ),
              Text('siya@gmail.com',style: TextStyle(color: Colors.teal,fontSize: 17),),
              Text('071 594 1573',style: TextStyle(color: Colors.teal,fontSize: 17),),
              Text('South African',style: TextStyle(color: Colors.teal,fontSize: 16),),
              Divider(
                indent: 140,
                endIndent: 140,
                color: Colors.blueGrey,
              ),
              Text('$bio',style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myButt('Edit Profile',Colors.lightBlue),
                  myButt('12 Posts',Colors.blueGrey),
                  myButt('41K Followers',Colors.teal),
                ],
              ),
              Divider(
                indent: 140,
                endIndent: 140,
                color: Colors.blueGrey,
              ),
            ],
          ),
        ),
          Positioned(
            child: CircleAvatar(radius: 50,backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3237/3237472.png'),),
            bottom: 227,
            left: 130,
          ),
        ],
        clipBehavior: Clip.none,
      ),
    ],
  );
}
Widget myButt(String name,Color col){
  return Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10),),color: col,
    ),
    child: Text(name,style: TextStyle(color: Colors.white,fontSize: 19),),
  );
}