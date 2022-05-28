import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'BMI Calculator',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}


//let's start by creating a new stateful widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //here I'm going to declare a variable for our custom radio button
  int currentIndex = 0;
  String result = "";
  double height = 0;
  double weight = 0;

  //let's declare the inputController to get the inputs value
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //first we will create a simple appbar

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xfffafafa),

          title: Text("BMI Calculator", style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600),),

          actions: [
            IconButton(
                onPressed: () {},

                icon: Icon(Icons.settings, color: Colors.black,)),
          ],
        ),

        //Now let's start bu creating the body of the app
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    radioButton("Man", Colors.blue, 0),
                    radioButton("Women", Colors.pink, 1)

                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                //now let's create our input form
                Text("Your height in cm :", style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w400),),

                SizedBox(height: 8.0,),
                TextField(
                  keyboardType: TextInputType.number,
                  //let's add the controller
                  controller: heightController,
                  textAlign: TextAlign.center,

                  decoration: InputDecoration(
                    hintText: "Your height in Cm ",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    )
                  ),
                ),

                SizedBox(height: 20.0,),
                //For the weight I am going to do the same thing
                //so just copy & paste the previous code


                Text("Your weight in Kg :", style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w400),),

                SizedBox(height: 8.0,),
                TextField(
                  keyboardType: TextInputType.number,
                  //let's add the controller
                  controller: weightController,
                  textAlign: TextAlign.center,

                  decoration: InputDecoration(
                      hintText: "Your weight in Kg ",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      )
                  ),
                ),

                SizedBox(height: 20.0,),
                //Now let's add the calculate button
                Container(
                  width: double.infinity,
                  height: 50.0,

                  child: FlatButton(
                      onPressed: (){
                        setState(() {
                          height = double.parse(heightController.value.text);
                          weight = double.parse(weightController.value.text);
                        });
                         calculateBmi(height, weight);
                      },

                      child: Text("Calculate",style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w600),),),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue
                  ),
                ),

                SizedBox(height: 20.0,),
                Container(
                    width: double.infinity,

                    child: Text("Your BMI is :",textAlign: TextAlign.center,style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),

                ),


                SizedBox(height: 50.0,),
                Container(
                  width: double.infinity,

                  child: Text("$result",textAlign: TextAlign.center,style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBmi (double height, double weight){
    double finalresult = weight / (height * height / 10000);
    String bmi = finalresult.toStringAsFixed(2);

    setState(() {
      result = bmi;
    });
  }


  //and here I'm going to declare a function to change the index value on button pressed
    void changeIndex (int index){
    setState((){
      currentIndex = index;
    });
    }

    //now i will create a new custom widget
    Widget radioButton(String value, Color color, int index){
    return Expanded(
        child: Container(
          //I will add some margin to the container
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          //let's add some height to the button
          height: 50.0,
          
          child: FlatButton(

            //when we click the button the currentIndex will have the value of the button index
              onPressed: (){
                changeIndex(index);
              },


              //now i want the color of my button change in function of it's selected or not
              color: currentIndex == index ? color : Colors.grey[200],//this line means if the current index is equal to the button index then put the color   //the main color that we will define otherwise make it grey
              //let's start some round border

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),

              //I will apply some modification to the button text color
              child: Text(value,
                style: TextStyle(color: currentIndex == index ? Colors.white : color, fontWeight: FontWeight.w600,fontSize: 18),
              )),
        )
    );
    }
}
