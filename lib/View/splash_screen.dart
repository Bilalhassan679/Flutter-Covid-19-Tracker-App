import 'dart:async';

import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math ;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(vsync: this,duration:const Duration(seconds: 3))..repeat();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),() => Get.to(() => const WorldState()));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Center(
              child: AnimatedBuilder(animation: _controller,
                  child:const SizedBox(
                    height: 200,
                    width: 200,
                  child:Image(image: AssetImage('images/virus.png')),),
                  builder: (BuildContext context,Widget? child){
                    return Transform.rotate(angle: _controller.value*2.0*math.pi,
                    child: child,
                    );
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height* .08,),
            const Align(
                alignment: Alignment.center,
                child: Text('Covid19 \n Tracker App',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
