import 'package:cal/Game.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

String init='';
Color initCol=MainColor.secondaryColor;

List<data> gameGrid=[];
String win='';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

int currindex=0;
  @override
  void initState() {
    super.initState();
clerdata();
  }

void  clerdata(){
  gameGrid=[data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),data(movedata:'',movcol: MainColor.secondaryColor),];

}  

String last=Player.player1;
String currmove='';
Color currcol=MainColor.secondaryColor;
void setData(int num){

if(last==Player.player1){
  currmove='O';
  currcol=Colors.greenAccent;
}else{
    currmove='X';
    currcol=Colors.redAccent;
}

setState(() {
  gameGrid[num]=data(movedata: currmove, movcol: currcol);
  last=currmove;
win;
});





checkres();





}

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
backgroundColor: MainColor.primaryColor,
      body:Column(
        
        children: [

           const Padding(padding: EdgeInsets.fromLTRB(0,80,0,0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[Text("Lets play\n Winner $win",style: const TextStyle(fontSize: 25,color: Colors.white),)] 
              ),
          const Spacer(),
        Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-250,
                  decoration: BoxDecoration(
                    color: MainColor.primaryColor
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10,
                      children: [
                        
                    gameBox(gameGrid[0].movedata,gameGrid[0].movcol,0), gameBox(gameGrid[1].movedata,gameGrid[1].movcol,1), gameBox(gameGrid[2].movedata,gameGrid[2].movcol,2), gameBox(gameGrid[3].movedata,gameGrid[3].movcol,3), gameBox(gameGrid[4].movedata,gameGrid[4].movcol,4), gameBox(gameGrid[5].movedata,gameGrid[5].movcol,5), gameBox(gameGrid[6].movedata,gameGrid[6].movcol,6), gameBox(gameGrid[7].movedata,gameGrid[7].movcol,7), gameBox(gameGrid[8].movedata,gameGrid[8].movcol,8)
                        
                        
                        
                       
                        ],
                      
                      ),
                  ),
                  
          ),


        ],
        ),

        bottomNavigationBar:  Container(


          margin:const EdgeInsets.fromLTRB(25, 0, 25, 0),
            width: MediaQuery.of(context).size.width-60,
            decoration:const  BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
              color: Colors.transparent,
            ),
          child: ClipRRect(


                borderRadius: const BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25)),
            child: BottomNavigationBar(
             
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              
              currentIndex: currindex,
              onTap: (value) {
                setState(() {
                  currindex=value;
                });
              },
              
              
              items: [
              
               BottomNavigationBarItem(
                icon:const  Icon(Icons.home),
                label: "Home",
                backgroundColor: MainColor.accentColor
                ),
                  BottomNavigationBarItem(
                icon:const  Icon(Icons.list),
                label: "items",
                 backgroundColor: MainColor.primaryColor
                ),
                  BottomNavigationBarItem(
                icon:const  Icon(Icons.exit_to_app_outlined),
                label: "Exit",
                backgroundColor: MainColor.secondaryColor
            
                ),
                  BottomNavigationBarItem(
                icon: const Icon(Icons.person_2_outlined),
                label: "Profile",
                 backgroundColor:Colors.greenAccent
            
                ),
            
            
            
            
            ]
            ),
          ),
          
          ),
       
      
    );
  }



// CircleAvatar button(String val,Color col){


// return CircleAvatar(
//   child: Text(val),
// maxRadius: 20,
// backgroundColor: col,
// );



// }




InkWell gameBox(String move,Color col,int boxnum){

return InkWell(
                          onTap: (){



setData(boxnum);

                            

                          },
                          child: Container(decoration: BoxDecoration(color:MainColor.secondaryColor),
                                                
                                                child: Center(child: Text(move,style: TextStyle(fontSize: 55,fontWeight: FontWeight.w300,color: col),)),
                                                
                                                ),
                        );



}




void checkres(){


  if(((!(gameGrid[0].movedata==''))&&(!(gameGrid[1].movedata==''))&&(!(gameGrid[2].movedata=='')))&&((gameGrid[0].movedata==gameGrid[1].movedata)&&(gameGrid[2].movedata==gameGrid[0].movedata))){

ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[0].movedata,gameGrid[0].movcol));
    clerdata();
  }
  else if(((!(gameGrid[0].movedata==''))&&(!(gameGrid[3].movedata==''))&&(!(gameGrid[6].movedata=='')))&&((gameGrid[3].movedata==gameGrid[0].movedata)&&(gameGrid[0].movedata==gameGrid[6].movedata))){


ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[0].movedata,gameGrid[0].movcol));
   clerdata();
  }
  else if(((!(gameGrid[3].movedata==''))&&(!(gameGrid[4].movedata==''))&&(!(gameGrid[5].movedata=='')))&&((gameGrid[3].movedata==gameGrid[4].movedata)&&(gameGrid[3].movedata==gameGrid[5].movedata))){


ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[5].movedata,gameGrid[5].movcol));
    clerdata();
  }
  else if(((!(gameGrid[7].movedata==''))&&(!(gameGrid[8].movedata==''))&&(!(gameGrid[6].movedata=='')))&&((gameGrid[7].movedata==gameGrid[8].movedata)&&(gameGrid[7].movedata==gameGrid[6].movedata))){


ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[7].movedata,gameGrid[7].movcol));
  clerdata();
  }


  else if(((!(gameGrid[7].movedata==''))&&(!(gameGrid[1].movedata==''))&&(!(gameGrid[4].movedata=='')))&&((gameGrid[7].movedata==gameGrid[4].movedata)&&(gameGrid[7].movedata==gameGrid[1].movedata))){


ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[7].movedata,gameGrid[7].movcol));
    clerdata();
  }

   else  if(((!(gameGrid[0].movedata==''))&&(!(gameGrid[4].movedata==''))&&(!(gameGrid[8].movedata=='')))&&((gameGrid[0].movedata==gameGrid[4].movedata)&&(gameGrid[0].movedata==gameGrid[8].movedata))){



ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[0].movedata,gameGrid[0].movcol));
    clerdata();
  }
  else if(((!(gameGrid[2].movedata==''))&&(!(gameGrid[4].movedata==''))&&(!(gameGrid[6].movedata=='')))&&((gameGrid[2].movedata==gameGrid[4].movedata)&&(gameGrid[2].movedata==gameGrid[6].movedata))){

 
ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[2].movedata,gameGrid[2].movcol));
   clerdata();
  }


  else if(((!(gameGrid[2].movedata==''))&&(!(gameGrid[5].movedata==''))&&(!(gameGrid[8].movedata=='')))&&((gameGrid[2].movedata==gameGrid[5].movedata)&&(gameGrid[2].movedata==gameGrid[8].movedata))){

ScaffoldMessenger.of(context).showSnackBar(Showwinner(gameGrid[2].movedata,gameGrid[2].movcol));
    clerdata();

  }

   else if((!(gameGrid[2].movedata==''))&&(!(gameGrid[5].movedata==''))&&(!(gameGrid[8].movedata==''))&&(!(gameGrid[0].movedata==''))&&(!(gameGrid[3].movedata==''))&&(!(gameGrid[6].movedata==''))&&(!(gameGrid[1].movedata==''))&&(!(gameGrid[4].movedata==''))&&(!(gameGrid[7].movedata==''))){

ScaffoldMessenger.of(context).showSnackBar(Showwinner("Sorry drawed",Colors.white));
    clerdata();

  }



}


}


class data{

String movedata;
Color movcol;
data({required this.movedata,required this.movcol});

String getdata(){

return movedata;

}

Color getdataColor(){

return movcol;

}











}



SnackBar Showwinner(String wininr,Color col){

win=wininr;
return SnackBar(content: Text("The Winner is :---"+wininr,style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
backgroundColor: col,
);

}










