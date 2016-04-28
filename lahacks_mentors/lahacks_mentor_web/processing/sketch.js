// import java.util.Map;

//Group availability
var grid_height = 25;
var grid_width = 100;
var grid_X = 500;
var grid_Y = 150;

//People avail at each slot
var group_avail; // 2D array = new ArrayList[35];

//Mentor availability
var mentors; //2D array - new HashMap<var, var[]>();

var signedIn = false;
var textBox = "";
var ind_X = 100;
var ind_Y = 150;

function setup() {
 createCanvas (1000, 1000);

 group_avail = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],
    [],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],
    []];

 //Load data
 var group_lines = loadStrings("group_avail.txt");
 for (var i = 0; i < group_lines.length; i++) {
   if (!group_lines[i].equals("null")) {
     group_avail[i] = group_lines[i].split(',');
   }
 }
 
 var mentors_lines = loadStrings("mentors.txt");
 for (var i = 0; i < mentors_lines.length; i++) {
   var line = mentors_lines[i].split(':'); //Format: ["Fay", "0,1,1,0,1,0,...35"]
   var slots = line[1].split(',').map(Number); //Format: [0,1,1,0,1,0,...35]
   mentors.push ({'name': line[0], 'slots' : slots}); //Format: {Fay, [0,1,1,1,0,...35]
 }
 
}

function draw() {
  background(0);
  
  //Mouse over group avail grid
  var hoverGrid = -1;
  if (touchX >= grid_X && touchX <= grid_X + 3 * grid_width && touchY >= grid_Y && touchY <= grid_Y + 24 * grid_height) {
      if (touchX >= grid_X && touchX <= grid_X + grid_width && touchY >= grid_Y + 23 * grid_height && touchY <= grid_Y + 24 * grid_height) {
       hoverGrid = 0; 
      }
      else if (touchX >= grid_X + grid_width && touchX <= grid_X + 2*grid_width) {
       hoverGrid = (touchY - grid_Y) / grid_height + 1; 
      }
      else if (touchX >= grid_X + 2*grid_width && touchX <= grid_X + 3*grid_width && touchY <= grid_Y + 10 * grid_height) {
       hoverGrid = (touchY - grid_Y) / grid_height + 25;
      }
      else hoverGrid = -1;
  }
  
  //Print people who are avail at time slot
  if (hoverGrid > -1 && hoverGrid <= 34) {
    fill(255);
    textSize(24);
    text("Available mentors: " + group_avail[hoverGrid].length + "/" + mentors.length, 100, 100);
    textSize(18);
    text("Available:",100, 150);
    textSize(18);
    text("Unavailable:", 300, 150);
    
    var p_X = 100;
    var p_Y = 200;
    textSize(15);
    for (var i = 0; i < group_avail[hoverGrid].length; i++) {
     text(group_avail[hoverGrid][i] + "", p_X, p_Y); 
     p_Y += 30;
    }
    
    p_X = 300;
    p_Y = 200;
    for (var i = 0; i < mentors.length; i++) {
      if (!group_avail[hoverGrid].includes(a[i])) {
         text(a[i] + "", p_X, p_Y);
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
      fill (255 - mentors.find(x => x.name === textBox)['slots'][0] * 100); //Check if this is correct
      rect (ind_X, ind_Y+(23*grid_height), grid_width, grid_height);
      
      //Saturday
      for (var i = 0; i < 24; i++) {
        fill (255 - mentors.find(x => x.name === textBox)['slots'][i+1]* 100); 
        rect (ind_X + grid_width, ind_Y+(i*grid_height), grid_width, grid_height);
      }
      
      //Sunday
      for (var i = 0; i < 10; i++) {
        fill (255 - mentors.find(x => x.name === textBox)['slots'][i+25] * 100); 
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
  for (var i = 0; i < 24; i++) {
    fill_grid(i+1);
    rect (grid_X + grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
  
  //Sunday
  for (var i = 0; i < 10; i++) {
    fill_grid(i+25);
    rect (grid_X + 2*grid_width, grid_Y+(i*grid_height), grid_width, grid_height);
  }
}

function touchStarted() {
  if (signedIn) {
    var num = -1;
    if (touchX >= ind_X && touchX <= ind_X + 3*grid_width && touchY >= ind_Y && touchY <= ind_Y + 24 * grid_height) {
      if (touchX >= ind_X && touchX <= ind_X + grid_width && touchY >= ind_Y + 23 * grid_height && touchY <= ind_Y + 24 * grid_height) {
         num = 0;
      }
      else if (touchX >= ind_X + grid_width && touchX <= ind_X + 2*grid_width) {
       num = (touchY - ind_Y) / grid_height + 1; 
      }
      else if (touchX >= ind_X + 2*grid_width && touchX <= ind_X + 3*grid_width && touchY <= ind_Y + 10 * grid_height) {
       num = (touchY - ind_Y) / grid_height + 25;
      }
      
      //println("num: " + num);
      clickSlot(textBox, num);
    }
    
    //Clicked submit button - save data!
    if (mouseOverRect(ind_X + 2*grid_width, ind_Y + 26*grid_height, 100, grid_height)){
      saveData();
    }
  }
  else {
    //Clicked sign in button
    if (mouseOverRect(ind_X + 2*grid_width, ind_Y + grid_height, 100, grid_height)) {
      signIn();
    } 
  }
}

function mouseOverRect(x, y, width1, height1) {
  return (touchX >= x && touchX <= x + width1 && touchY >= y && touchY <= y + height1);  
}

function keyPressed() {
   if (!signedIn) {
     switch (key) {
       case BACKSPACE: 
         if (textBox.length > 0) 
           textBox = textBox.substring (0, textBox.length - 1);
         break;
        case ENTER:
           signIn();
          break;
       
      default: textBox += key; 
        break;
     }
   }
}

function signIn() {
  if (textBox.length > 0) {
    if (mentors.some(x => x.name === textBox)) { 
      signedIn = true;
    }
    else {
      addMentor(textBox);
      signedIn = true;
    }
  }
}

function signOut() {
   textBox = "";
   signedIn = false;
}

function saveData() {
  saveStrings("group_avail.txt", generateGroupLines());
  savevars("mentors.txt", generateMentorLines());
}

function generateGroupLines() {
  var lines;
  for (var i = 0; i < 35; i++) {
    var line = "";
    for (var j = 0; j < group_avail[i].length; j++) {
      var x = group_avail[i][j];
      line += x;
      if (j < group_avail[i].length - 1) 
        line += ",";
    }
    if (group_avail[i].length > 0)
      lines[i] = line;
  }
  return lines;
}

function generateMentorLines() {
  var lines;
  for (var i = 0; i < mentors.length; i++) {
    var slots = mentors[i]['slots'];
    var name = mentors[i]['name'];
    lines[i] = name + ":";
    for (var j = 0; j < slots.length; j++) {
      lines[i] += slots[j];
      if (j < slots.length - 1) 
        lines[i] += ",";
    }
  }
  return lines;
}

function addMentor(name) {
  if(!name.equals("null") && !mentors.some(x => x.name === name))
    mentors.push ({'name': name, 'slots' : []});
}

function clickSlot(name, timeSlot) {
  if (timeSlot < 35) {
    if (mentors.some(x => x.name === name)['slots'][timeSlot] == 0) {
      mentors.some(x => x.name === name)['slots'][timeSlot] = 1;
      group_avail[timeSlot].push(name); 
    }
    else {
      mentors.some(x => x.name === name)['slots'][timeSlot] = 0;
      var index = group_avail[timeSlot].indexOf(name);
      group_avail[timeSlot].splice(index, 1);
    }
  }
  //else println("error");
}

function fill_grid(num) {
   if (mentors.length == 0) 
    fill(100);
   else 
    fill(100 - (100 * group_avail[num].length / mentors.length));
}

function printLines(lines) {
  //group_avail ArrayList[] group_avail = new ArrayList[35];
  for (var i = 0; i < lines.length; i++) {
    //println(lines[i]);
  }
}