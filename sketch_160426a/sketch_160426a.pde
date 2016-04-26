import java.util.Map;

//Group availability
int grid_height = 25;
int grid_width = 100;
int grid_X = 500;
int grid_Y = 150;
//People avail at each slot
ArrayList[] group_avail = new ArrayList[35];

//Mentor availability
HashMap<String, int[]> mentors = new HashMap<String, int[]>();
int totalMentors = 0;
Boolean signedIn = false;
String textBox = "";
int ind_X = 100;
int ind_Y = 150;

void setup() {
 size (1000, 1000);
 
 for (int i = 0; i < 35; i++) {
   group_avail[i] = new ArrayList();
   group_avail[i].add ("Carly");
 }
 
 group_avail[3].add("Ceew");
 group_avail[3].add("Jake");
 group_avail[4].add("Hi");
 mentors.put("Carly", new int[35]);
 mentors.put("Ceew", new int[35]);
 mentors.put("Hi", new int[35]);
 mentors.put("Jake", new int[35]);
 totalMentors = 3;
}

void draw() {
  background(0);
  
  //Mouse over group avail grid
  int hoverGrid = -1;
  if (mouseX >= grid_X && mouseX <= grid_X + 3 * grid_width && mouseY >= grid_Y && mouseY <= grid_Y + 24 * grid_height) {
    println("in grid");
      if (mouseX >= grid_X && mouseX <= grid_X + grid_width && mouseY >= grid_Y + 23 * grid_height && mouseY <= grid_Y + 24 * grid_height) {
       hoverGrid = 0; 
       println("in 0");
      }
      else if (mouseX >= grid_X + grid_width && mouseX <= grid_X + 2*grid_width) {
       hoverGrid = (mouseY - grid_Y) / grid_height + 1; 
       println ("in " + hoverGrid);
      }
      else if (mouseX >= grid_X + 2*grid_width && mouseX <= grid_X + 3*grid_width && mouseY <= grid_Y + 10 * grid_height) {
       hoverGrid = (mouseY - grid_Y) / grid_height + 25;
        println ("in " + hoverGrid);
      }
      else hoverGrid = -1;
  }
  
  //Print people who are avail at time slot
  if (hoverGrid > -1 && hoverGrid <= 34) {
    fill(255);
    textSize(24);
    text("Available mentors: " + group_avail[hoverGrid].size() + "/" + totalMentors, 100, 100);
    textSize(18);
    text("Available:",100, 150);
    textSize(18);
    text("Unavailable:", 300, 150);
    
    int p_X = 100;
    int p_Y = 200;
    textSize(15);
    for (int i = 0; i < group_avail[hoverGrid].size(); i++) {
     text(group_avail[hoverGrid].get(i) + "", p_X, p_Y); 
     p_Y += 30;
    }
    
    p_X = 300;
    p_Y = 200;
    String[] a = mentors.keySet().toArray(new String[totalMentors]);
    for (int i = 0; i < totalMentors; i++) {
      if (!group_avail[hoverGrid].contains(a[i])) {
         text(String.valueOf(a[i]) + "", p_X, p_Y);
         p_Y += 30;
      }
    }
  }
  
  //Sign up OR display individual avail
  //mentors.put("name", new int[35]);
  
  if (hoverGrid < 0) {
    if (!signedIn) {
      textSize(20);
      text("Name:", 100, 150);
      text(textBox, 200, 150);
    }
    else {
      textSize(24);
      text("My Availability: ", 100, 100);
      
      //Display individual availability
      fill (100);
      rect (ind_X, ind_Y,3*grid_width, 24*grid_height);
      textSize(15);
      text("Friday", ind_X, ind_Y - 10);
      text("Saturday", ind_X + grid_width, ind_Y - 10);
      text("Sunday", ind_X + 2*grid_width, ind_Y - 10);
      
      //Friday
      fill (mentors.get(textBox)[0] * 100);
      rect (ind_X, ind_Y+(23*grid_height), grid_width, grid_height);
      
      //Saturday
      for (int i = 0; i < 24; i++) {
        fill ((mentors.get(textBox)[i]* 100));
        rect (ind_X + grid_width, ind_Y+(i*grid_height), grid_width, grid_height);
      }
      
      //Sunday
      for (int i = 0; i < 10; i++) {
        fill ((mentors.get(textBox)[i] * 100));
        rect (ind_X + 2*grid_width, ind_Y+(i*grid_height), grid_width, grid_height);
      }
      
    }
  }
  
  //Display group availability
  fill (100);
  rect (grid_X, grid_Y,3*grid_width, 24*grid_height);
  textSize(15);
  text("Friday", grid_X, grid_Y - 10);
  text("Saturday", grid_X + grid_width, grid_Y - 10);
  text("Sunday", grid_X + 2*grid_width, grid_Y - 10);
  
  //Friday
  fill (255 - (group_avail[0].size() / totalMentors) * 255);
  rect (grid_X, grid_Y+(23*grid_height), grid_width, grid_height);
  
  //Saturday
  for (int i = 0; i < 24; i++) {
    fill (255 - (group_avail[i+1].size()* 255) / totalMentors);
    rect (grid_X + grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
  
  //Sunday
  for (int i = 0; i < 10; i++) {
    fill (255 - (group_avail[i+25].size() * 255) / totalMentors);
    rect (grid_X + 2*grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
}

void mousePressed() {
  
}

void keyPressed() {
   if (!signedIn) {
     switch (key) {
       case BACKSPACE: 
         if (textBox.length() > 0) 
           textBox = textBox.substring (0, textBox.length() - 1);
         break;
        case ENTER:
          if (textBox.length() > 0) {
            if (mentors.containsKey(textBox)) {
              signedIn = true;
            }
            else {
              mentors.put(textBox, new int[35]);
              signedIn = true;
            }
          }
          break;
      default: textBox += key; 
        break;
     }
   }
}