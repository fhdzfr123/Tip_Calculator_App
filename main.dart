import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: BillSplitter(),
  )
  );
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage=0;
  int _personCounter=0;
  double _billAmount=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total per person",style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.green,
                    ),),
                    Text("\$ ${CalculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Colors.green,
                    ),),
                  ],
                ),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.greenAccent.shade100,
                  style: BorderStyle.solid
                ),
                  borderRadius: BorderRadius.circular(10)
              ),

              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount ",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount=double.parse(value);
                      }
                      catch(exception){
                        _billAmount=0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split",style: TextStyle(
                        color: Colors.green,
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personCounter>1)
                                  {
                                    _personCounter--;
                                  }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.green.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                                ),
                              ),
                            ),
                          ),

                          Text("$_personCounter",style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                          InkWell(
                            onTap:  (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7)
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                            ),
                          ),



                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip",style: TextStyle(
                        color: Colors.green,
                      ),),
                      Padding(
                        padding: EdgeInsets.all(17),
                        child: Text("\$ ${(CalculateTotalTip(_billAmount, _tipPercentage)).toStringAsFixed(2)}",style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),),
                      )
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage",style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.green,
                          inactiveColor: Colors.greenAccent,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                        onChanged: (double newvalue){
                        setState(() {
                          _tipPercentage=newvalue.round();
                        });
                        })
                    ],
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
  CalculateTotalPerPerson(double billAmount,int persons,int tippercent){
    var totalPerPerson=(CalculateTotalTip(billAmount, tippercent)+billAmount)/persons;


    return totalPerPerson.toStringAsFixed(2);
  }

  CalculateTotalTip(double billAmount,int tippercent){
    double totalTip=0;
if( billAmount<0 || billAmount.toString().isEmpty || billAmount==null)
  {

  }
else
  {
  totalTip=(billAmount*tippercent)/100;
  }
return totalTip;
  }
}
