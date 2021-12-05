import 'package:driverid/screens/redeem/redeem_list.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';
import 'compensation_list.dart';


class RedeemTabMenuScreen extends StatefulWidget{
  const RedeemTabMenuScreen() : super();

  @override
  _RedeemTabMenuScreenState createState() => _RedeemTabMenuScreenState();

}



class _RedeemTabMenuScreenState extends State<RedeemTabMenuScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState(){
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose(){
    _tabController?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBarCustom(title: 'Tukar Point',),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            //DeviderWidget(height: 0,),
            TabBar(
              controller:_tabController,
              indicatorColor: Styles.colorPrimary,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicatorWeight: 4,
              tabs: [
                Tab(child: Text('Belum Diambil', ),),
                Tab(child: Text('Sudah Diambil', ),),
              ],
            ),
            DeviderWidget(height: 0,),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: CompensationListScreen(),
                      //child: RedeemLayout(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: CompensationListScreen(viewType: 'done',),
                      //child: RedeemListScreen(),
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }


  Widget RedeemLayout(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset('assets/images/dummypoint.png')
        ],
      ),
    );
  }


}


