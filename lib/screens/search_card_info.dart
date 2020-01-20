import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/search_results_screen.dart';
import 'package:leaf/screens/seat_selection_screen.dart';
import 'package:leaf/services/database_service.dart';

class SearchCardInfo extends StatefulWidget {
  final int num;
  final Ride ride;

  const SearchCardInfo({
    Key key,
    this.num,
    this.ride,
  }) : super(key: key);

  @override
  _SearchCardInfoState createState() => _SearchCardInfoState();
}

class _SearchCardInfoState extends State<SearchCardInfo> {

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: true,
        title: Hero(
            tag: 'animateText',
            child: Material(
              color: Color(0xff111e2e),
              child: Text(
                "Übersicht",
                style: TextStyle(
                  fontFamily: 'UbuntuRegular',
                  fontSize: 22,
                  color: Color(0xffE6EFE9),
                ),
              ),
            )),
        leading: Hero(
          tag: 'animateIcon',
          child: Material(
            color: Color(0xff111e2e),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xffe8b641),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("users/$widget.ride.creatorId").snapshots(),
        //future: DatabaseService.searchRides('Oberhausen', 'Unterhausen', '23.01.2020', '12:00'),
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {

          // }
          //User user = User.fromDoc(snapshot.data);

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff192C43),
                valueColor: AlwaysStoppedAnimation(
                  Color(0xff213a59),
                ),
              ),
            );
          }

          if(snapshot.data.documents.length != 0) {
            User user = User.fromDoc(snapshot.data.documents[0]);
            //Ride ride = Ride.fromDoc(snapshot.data.documents[0]);
            print(widget.ride.creatorId);
            print('Hallo');
            //return Container(child: Text(user.name,));

            return SearchCardItemExtended(user: user, ride: widget.ride,);
          }
          return Container();
        },
      ),
    );
  }
}


class SearchCardItemExtended extends StatelessWidget {

  final User user;
  final Ride ride;

  const SearchCardItemExtended({this.user, this.ride});

  @override
  Widget build(BuildContext context) {

    _submit() async {
      DatabaseService.updateRide(ride, context);
    }

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          physics: new BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            Hero(
              tag: 'card$num',
              flightShuttleBuilder: (BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,) {
                return SingleChildScrollView(
                  child: fromHeroContext.widget,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          0, // Move to right 10  horizontally
                          2.5, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xff192C43),
                  ),
                  child: SizedBox(
                    height: 168,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[

                                  /// Start Ziel -----------------------------------------
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Material(
                                        color: Color(0xff192C43),
                                        child: Text(
                                          'Von ' + ride.origin,
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 20,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Color(0xff192C43),
                                        child: Text(
                                          'nach ' +
                                              ride.destination,
                                          style: TextStyle(
                                            fontFamily: 'UbuntuLight',
                                            fontSize: 20,
                                            color: Color(0xffE6EFE9),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// Drei Icons -----------------------------------------
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          EdgeInsets.only(right: 0),
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 22,
                                                  child: Image.asset(
                                                      'assets/images/thin_clock.png'),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Material(
                                                  color:
                                                  Color(0xff192C43),
                                                  child: Text(
                                                    'Abfahrt',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'UbuntuLight',
                                                      fontSize: 12,
                                                      color: Color(
                                                          0xffE6EFE9),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color:
                                                  Color(0xff192C43),
                                                  child: Text(
                                                    ride.time,
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'UbuntuLight',
                                                      fontSize: 16,
                                                      color: Color(
                                                          0xffE6EFE9),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(right: 0),
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 22,
                                                  child: Image.asset(
                                                      'assets/images/thin_hourglass.png'),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Material(
                                                  color:
                                                  Color(0xff192C43),
                                                  child: Text(
                                                    'Fahrtdauer',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'UbuntuLight',
                                                      fontSize: 12,
                                                      color: Color(
                                                          0xffE6EFE9),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color:
                                                  Color(0xff192C43),
                                                  child: Text(
                                                    '1,5',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'UbuntuLight',
                                                      fontSize: 16,
                                                      color: Color(
                                                          0xffE6EFE9),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 22,
                                                child: Image.asset(
                                                    'assets/images/thin_euro.png'),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Material(
                                                color: Color(0xff192C43),
                                                child: Text(
                                                  ride.price,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'UbuntuLight',
                                                    fontSize: 12,
                                                    color:
                                                    Color(0xffE6EFE9),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Color(0xff192C43),
                                                child: Text(
                                                  '7',
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'UbuntuLight',
                                                    fontSize: 16,
                                                    color:
                                                    Color(0xffE6EFE9),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// Flaggen ------------------------------------------------------
                        Padding(
                          padding: EdgeInsets.only(right: 16, left: 32),
                          child: Container(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                /// Flagge oben ------------------------------------------
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight:
                                          Radius.circular(3.0),
                                          bottomLeft:
                                          Radius.circular(3.0)),
                                      color: Color(0xff294970),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius:
                                          3.0, // soften the shadow
                                          spreadRadius:
                                          2.0, //extend the shadow
                                          offset: Offset(
                                            2.5,
                                            // Move to right 10  horizontally
                                            2.5, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    height: 76,
                                    width: 57,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Material(
                                              color: Color(0xff294970),
                                              child: Text(
                                                user.name,
                                                style: TextStyle(
                                                  fontFamily:
                                                  'UbuntuLight',
                                                  fontSize: 12,
                                                  color:
                                                  Color(0xff0cce6b),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: CircleAvatar(
                                                radius: 21.0,
                                                backgroundImage: AssetImage(
                                                    'assets/images/Profilbild_Paul.png'),
                                                backgroundColor:
                                                Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                  width: 57,
                                ),

                                /// Flagge unten -----------------------------------------
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(3.0),
                                          topLeft: Radius.circular(3.0)),
                                      color: Color(0xff213A59),
                                    ),
                                    height: 76,
                                    width: 57,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 5, left: 5, bottom: 18),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                          child: Image.asset(
                                            'assets/images/Fahrtinfo_Leaf.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Color(0xff111e2e),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Color(0xff213A59),
                    // Schatten???
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            user.car,
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 16,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            user.car,
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 14,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            'Info',
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 16,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            'Fährt die Strecke regelmäßig\nStudent der HFU\n' +
                                user.mood +
                                '\n' +
                                user.smoke +
                                '\n' +
                                user.pet,
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 14,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            'Bezahlung',
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 16,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            'PayPal',
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 14,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                        ),
                        Material(
                          color: Color(0xff213A59),
                          child: Text(
                            'Verfügbare Plätze',
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 16,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                          width: double.maxFinite,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: GestureDetector(
                                onTap: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SeatSelectionScreen();
                                      },
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Hero(
                                    tag: 'animateCar',
                                    child: Image.asset(
                                        'assets/images/Sitzwahl_Auto_Draufsicht.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 52,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  EdgeInsets.only(bottom: 26, right: 8, left: 32),
                  child: SizedBox(
                    child: RaisedButton(
                      onPressed: () async {
                        await Future.delayed(Duration(milliseconds: 200));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SeatSelectionScreen();
                            },
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      color: Color(0xff213A59),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff0cce6b)),
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'SITZPLATZWAHL',
                        style: TextStyle(
                          color: Color(0xff0cce6b),
                          fontSize: 14,
                          fontFamily: 'UbuntuMedium',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  EdgeInsets.only(bottom: 26, left: 8, right: 32),
                  child: SizedBox(
                    child: RaisedButton(
                      onPressed: _submit,
                      color: Color(0xff0cce6b),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'FAHRT BUCHEN',
                        style: TextStyle(
                          color: Color(0xff111e2e),
                          fontSize: 14,
                          fontFamily: 'UbuntuMedium',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}