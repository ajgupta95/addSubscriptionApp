
import 'package:flutter/material.dart';
import 'package:subcription_manager/models/myPlan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../screens/planDetail.dart';


class PlanList extends StatefulWidget {
  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  int _page;
  Plan plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Subcriptions",
        style: TextStyle(
          color:Colors.black,
          fontSize: 28,
        ),),
        backgroundColor: Colors.white,


      ),
      body:null ,
      backgroundColor: Colors.white,
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.black,
        
    //     onPressed: (){
    //       print('want to add');
    //      Navigator.push(context, MaterialPageRoute(builder: (context) {
		//   return PlanDetail( plan);
	  // }));

    //     },
    //      tooltip: 'Add Contact',
    //     child: Icon(Icons.add),
        
        
    //     ),
    bottomNavigationBar: CurvedNavigationBar(
      color: Colors.blue,
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.black,
      height: 60,
      items: <Widget>[
        Icon(Icons.menu,size: 30,color: Colors.white,),
                Icon(Icons.add,size: 30,color: Colors.white,),
        Icon(Icons.filter_list,size: 30,color: Colors.white),
        Icon(Icons.sort,size: 30,color: Colors.white),



      ],
      animationCurve: Curves.bounceInOut,
      index: 1,
      animationDuration: Duration(
        milliseconds:200
      ),
      onTap: (index){
        print('Current index is $index');
        // setState(() {
        //   _page=index;
        // });
        if(index==1){
           Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return PlanDetail( plan);
	   }));
        }
      },
    ),
 
    );
  }
}

