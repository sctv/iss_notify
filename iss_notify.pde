//using json get as an example, pointing at iss-pass
//using info from https://stackoverflow.com/questions/25781652/converting-epoch-time-stamp-to-readable-date-not-working
//http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html?is-external=true

import http.requests.*;
import java.text.SimpleDateFormat.*; 
import java.util.Date.*;


public void setup() 
{
//	size(400,400);
//	smooth();
long epoch = 1498230903;
long now = System.currentTimeMillis();
String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(now));
println(date);	
  GetRequest get = new GetRequest("http://api.open-notify.org/iss-pass.json?lat=54.978301&lon=-1.587802");
  get.send(); // program will wait untill the request is completed
  println("response: " + get.getContent());

  JSONObject response = parseJSONObject(get.getContent());
  println("message: " + response.getString("message"));//status of response
  JSONArray passes = response.getJSONArray("response");

  println("risetimes ");
  for(int i=0;i<passes.size();i++) {
    JSONObject rise = passes.getJSONObject(i);//gets each of the passes[duration and risetime]
    println(rise);
   // String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(rise*1000));
   println("risetime: " + rise.getInt("risetime"));
   println("duration: " + rise.getInt("duration"));
   //println(i);
  }
}
 