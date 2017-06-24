//using json get as an example, pointing at iss-pass
//using info from https://stackoverflow.com/questions/25781652/converting-epoch-time-stamp-to-readable-date-not-working
//http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html?is-external=true
// to do count down timer , print times of the passes in human readable. 
// switch on gps locations  

import http.requests.*;
import java.text.SimpleDateFormat.*; 
import java.util.Date.*;


public void setup() 
{
//	size(400,400);
//	smooth();
//long epoch = 1498230903;
long now = System.currentTimeMillis();
String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(now));
long nowtimesec = now / 1000;

println(nowtimesec);
println(date);	
  GetRequest get = new GetRequest("http://api.open-notify.org/iss-pass.json?lat=54.978301&lon=-1.587802"); //newcastle
  get.send(); // program will wait untill the request is completed
  //println("response: " + get.getContent());

  JSONObject response = parseJSONObject(get.getContent());
 // println("message: " + response.getString("message"));//status of response
  JSONArray passes = response.getJSONArray("response");

  println("risetimes ");
  for(int i=0;i<passes.size();i++) {
    JSONObject rise = passes.getJSONObject(i);//gets each of the passes[duration and risetime]
   //println(rise);
   println(" ");
   println("pass " + (i+1));
   long pass = rise.getInt("risetime");
   //println(pass);
   long pass1000=pass*1000;
   //println(pass1000);
   String datetime = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(pass1000));
   println("datetime: " + datetime); 
  
   //long pass = 1000 * rise.getInt("risetime");
   //int pass = rise.getInt("risetime");
   
   //println("long pass: " + pass);
   long timetopass = (((pass1000 - now))/60000);
   println("time till next: " + timetopass + " minutes");
   //println("time to next rise " + rise.getInt("risetime"));  
   //println("risetime: " + rise.getInt("risetime"));
   println("duration: " + (float(rise.getInt("duration"))/60) + " minutes");
   //println(i);
  }
}
 