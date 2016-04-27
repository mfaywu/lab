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
ArrayList<String> mentor_names = new ArrayList<String>();
int totalMentors = 0;
Boolean signedIn = false;
String textBox = "";
int ind_X = 100;
int ind_Y = 150;

void setup() {
 size (1000, 1000);
 for (int i = 0; i < 35; i++) {
  group_avail[i] = new ArrayList<String>(); 
 }
 //Load data
 String group_lines[] = loadStrings("group_avail.txt");
 for (int i = 0; i < group_lines.length; i++) {
   if (!group_lines[i].equals("null")) {
     String[] nums = split(group_lines[i], ','); 
     for (int j = 0; j < nums.length; j++) {
         group_avail[i].add(nums[j]);
         print(group_avail[i]);
     }
   }
 }
 
 String mentors_lines[] = loadStrings("mentors.txt");
 for (int i = 0; i < mentors_lines.length; i++) {
   String[] line = split(mentors_lines[i], ':');
   int[] nums = int(split(line[1], ','));
   mentors.put(line[0], new int[35]);
   mentor_names.add(line[0]);
   for (int j = 0; j < 35; j++) {
    mentors.get(line[0])[j] = nums[j]; 
   }
   totalMentors++;
 }
 
}

void draw() {
  background(0);
  
  //Mouse over group avail grid
  int hoverGrid = -1;
  if (mouseX >= grid_X && mouseX <= grid_X + 3 * grid_width && mouseY >= grid_Y && mouseY <= grid_Y + 24 * grid_height) {
      if (mouseX >= grid_X && mouseX <= grid_X + grid_width && mouseY >= grid_Y + 23 * grid_height && mouseY <= grid_Y + 24 * grid_height) {
       hoverGrid = 0; 
      }
      else if (mouseX >= grid_X + grid_width && mouseX <= grid_X + 2*grid_width) {
       hoverGrid = (mouseY - grid_Y) / grid_height + 1; 
      }
      else if (mouseX >= grid_X + 2*grid_width && mouseX <= grid_X + 3*grid_width && mouseY <= grid_Y + 10 * grid_height) {
       hoverGrid = (mouseY - grid_Y) / grid_height + 25;
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
    String[] a = mentors.keySet().toArray(new String[totalMentors]); //TODO
    for (int i = 0; i < totalMentors; i++) {
      if (!group_avail[hoverGrid].contains(a[i])) {
         text(String.valueOf(a[i]) + "", p_X, p_Y);//text(String.valueOf(a[i]) + "", p_X, p_Y);
         p_Y += 30;
      }
    }
  }
  
  //Sign up OR display individual avail
  if (hoverGrid < 0) {
    if (!signedIn) {
      fill (240);
      textSize(20);
      text("Name:", 100, 150);
      text(textBox, 200, 150);
      
      if (mouseOverRect(ind_X + 2*grid_width, ind_Y + grid_height, 100, grid_height))
        fill (50);
      else
        fill (100);
      rect (ind_X + 2*grid_width, ind_Y + grid_height, 100, grid_height);
      fill (255);
      text("Sign in", ind_X + 2*grid_width + 5, ind_Y + 2*grid_height - 5);
    }
    else {
      textSize(24);
      fill (100);
      text("My Availability: ", 100, 100);
      
      //Display individual availability
      fill (100);
      rect (ind_X, ind_Y,3*grid_width, 24*grid_height);
      textSize(15);
      text("Friday", ind_X, ind_Y - 10);
      text("Saturday", ind_X + grid_width, ind_Y - 10);
      text("Sunday", ind_X + 2*grid_width, ind_Y - 10);
      
      //Friday
      fill (255 - mentors.get(textBox)[0] * 100);
      rect (ind_X, ind_Y+(23*grid_height), grid_width, grid_height);
      
      //Saturday
      for (int i = 0; i < 24; i++) {
        fill (255 - (mentors.get(textBox)[i+1]* 100));
        rect (ind_X + grid_width, ind_Y+(i*grid_height), grid_width, grid_height);
      }
      
      //Sunday
      for (int i = 0; i < 10; i++) {
        fill (255 - (mentors.get(textBox)[i+25] * 100));
        rect (ind_X + 2*grid_width, ind_Y+(i*grid_height), grid_width, grid_height);
      }
      
      //Submit button to save
      if (mouseOverRect(ind_X + 2*grid_width, ind_Y + 26*grid_height, 100, grid_height))
        fill (50);
      else
        fill (100);
      rect (ind_X + 2*grid_width, ind_Y + 26*grid_height, 100, grid_height);
      fill (255);
      text("Submit", ind_X + 2*grid_width + 5, ind_Y + 27*grid_height - 5);
      
      //Sign out button
      /*if (mouseOverRect(grid_X + 3*grid_width, 50, grid_width, grid_height)) 
        fill (50);
      else
        fill (100);
      rect (grid_X + 3*grid_width, 50, grid_width, grid_height);
      fill (255);
      text("Sign out", grid_X + 3*grid_width, 50, grid_width, grid_height);*/
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
  fill_grid(0);
  rect (grid_X, grid_Y+(23*grid_height), grid_width, grid_height);
  
  //Saturday
  for (int i = 0; i < 24; i++) {
    fill_grid(i+1);
    rect (grid_X + grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
  
  //Sunday
  for (int i = 0; i < 10; i++) {
    fill_grid(i+25);
    rect (grid_X + 2*grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
}

void mousePressed() {
  if (signedIn) {
    int num = -1;
    if (mouseX >= ind_X && mouseX <= ind_X + 3*grid_width && mouseY >= ind_Y && mouseY <= ind_Y + 24 * grid_height) {
      if (mouseX >= ind_X && mouseX <= ind_X + grid_width && mouseY >= ind_Y + 23 * grid_height && mouseY <= ind_Y + 24 * grid_height) {
         num = 0;
      }
      else if (mouseX >= ind_X + grid_width && mouseX <= ind_X + 2*grid_width) {
       num = (mouseY - ind_Y) / grid_height + 1; 
      }
      else if (mouseX >= ind_X + 2*grid_width && mouseX <= ind_X + 3*grid_width && mouseY <= ind_Y + 10 * grid_height) {
       num = (mouseY - ind_Y) / grid_height + 25;
      }
      
      //println("num: " + num);
      clickSlot(textBox, num);
    }
    
    //Clicked submit button - save data!
    if (mouseOverRect(ind_X + 2*grid_width, ind_Y + 26*grid_height, 100, grid_height)){
      saveData();
    }
    
    /*if (mouseOverRect(grid_X + 3*grid_width, 50, grid_width, grid_height)) {
      //TODO: Warn users about not saving the data before signing out
     signOut(); 
    }*/
  }
  else {
    //Clicked sign in button
    if (mouseOverRect(ind_X + 2*grid_width, ind_Y + grid_height, 100, grid_height)) {
      signIn();
    } 
  }
}

Boolean mouseOverRect(int x, int y, int width1, int height1) {
  return (mouseX >= x && mouseX <= x + width1 && mouseY >= y && mouseY <= y + height1);  
}

void keyPressed() {
   if (!signedIn) {
     switch (key) {
       case BACKSPACE: 
         if (textBox.length() > 0) 
           textBox = textBox.substring (0, textBox.length() - 1);
         break;
        case ENTER:
           signIn();
          break;
       
      default: textBox += key; 
        break;
     }
   }
}

void signIn() {
  if (textBox.length() > 0) {
    if (mentors.containsKey(textBox)) {
      signedIn = true;
    }
    else {
      addMentor(textBox);
      signedIn = true;
    }
  }
}

void signOut() {
   textBox = "";
   signedIn = false;
}

void saveData() {
  String lines[] = new String[35];
  for (int i = 0; i < 35; i++) {
    String line = "";
    for (int j = 0; j < group_avail[i].size(); j++) {
      String x = String.valueOf(group_avail[i].get(j));
      line += x;
      if (j < group_avail[i].size() - 1) line += ",";
    }
    if (group_avail[i].size() > 0)
      lines[i] = line;
  }
  printLines(lines);
  saveStrings("group_avail.txt", lines);

  String lines1[] = new String[totalMentors];
  for (int i = 0; i < totalMentors; i++) {
    int[] slots = mentors.get(mentor_names.get(i));
    String x = String.valueOf(mentor_names.get(i));
    lines1[i] = x + ":";
    for (int j = 0; j < slots.length; j++) {
      lines1[i] += slots[j];
      if (j < slots.length - 1) lines1[i] += ",";
    }
  }
  printLines(lines1);
  saveStrings("mentors.txt", lines1);
  
}

void addMentor(String name) {
  if(mentors.containsKey(name))
    return;
  else {
    if (!name.equals("null")) {
      mentors.put(name, new int[35]);
      mentor_names.add(name);
      totalMentors++;
    }
  }
}

void clickSlot(String name, int timeSlot) {
  if (timeSlot < 35) {
    if (mentors.get(name)[timeSlot] == 0) {
      mentors.get(name)[timeSlot] = 1;
      group_avail[timeSlot].add(name);
    }
    else {
      mentors.get(name)[timeSlot] = 0;
      group_avail[timeSlot].remove(name);
    }
  }
  //else println("error");
}

void fill_grid(int num) {
   if (totalMentors == 0) fill(100);
   else fill(100 - (100 * group_avail[num].size() / totalMentors));
}

void printLines(String[] lines) {
  //group_avail ArrayList[] group_avail = new ArrayList[35];
  for (int i = 0; i < lines.length; i++) {
    //println(lines[i]);
  }
}