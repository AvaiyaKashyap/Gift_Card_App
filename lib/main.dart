

import 'package:ad_test/homePage.dart';
import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:ad_test/global.dart';
void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: adtest(),
  ));
}
class adtest extends StatefulWidget {
  const adtest({Key? key}) : super(key: key);

  @override
  State<adtest> createState() => _adtestState();
}

class _adtestState extends State<adtest> {
  bool isRewardedLoaded=false;
  @override
  void initState() {
    // TODO: implement initState
    FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true //default false
    );
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadRewarded();
  }

  void loadRewarded()
  {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_9_16_39S_APP_INSTALL#YOUR_PLACEMENT_ID ",
      listener: (result,value)
        {
          if(result==RewardedVideoAdResult.LOADED)
           {
             print("Rewarded Loaded.");
             isRewardedLoaded=true;
           }
          if(result==RewardedVideoAdResult.VIDEO_CLOSED)
            {
              isRewardedLoaded=false;
              loadRewarded();
            }
          if(result==RewardedVideoAdResult.VIDEO_COMPLETE)
            {
              print("user Got Rewards");
             setState((){
               global.TotalPoint +=500;
             });
            }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyanAccent,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children:[
                  Container(
                    color: Colors.cyanAccent,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Points:",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                        Text("${global.TotalPoint}",style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: ListView(
                    children: global.cards.map((e) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListTile(
                           // leading: Image.asset('${e['image']}',height: 100,width: 60,),
                            title: Text('${e['cardName']}'),
                            subtitle: Text('${e['requiredPoints']}'),
                            trailing: Text('${e['cardPrice']}'),
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                )),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.brown,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    child: Text("1 Point per AD"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        ElevatedButton(onPressed: () {
                          FacebookRewardedVideoAd.showRewardedVideoAd();
                        }, child: Text("Earn Points")),
                      ElevatedButton(onPressed: () {}, child: Text("Redeem Gift"))

                    ],
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
