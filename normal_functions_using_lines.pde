import peasy.*;

PeasyCam cam;
ArrayList<ArrayList<PVector>> image;
ArrayList<ArrayList<PVector>> grid = new ArrayList<ArrayList<PVector>>();
FloatList colorList = new FloatList();
ArrayList<ArrayList<ArrayList<PVector>>> animation;

int status = 0;
int xedge,yedge;
int divideConst = 200;
int stepSize = 10;
int circleSize = 5;
int no_of_Frames = 360;
int currentFrame = 0;

int GRID_DISPLAY = 0;
int IMG_DISPLAY = 1;
int ANIMATION_DISPLAY = 2;
int REVERSE_ANIMATION_DISPLAY = 3;

void setup() {
  size(600, 600, P3D);
  colorMode(HSB);
  background(0);

  cam = new PeasyCam(this, 500);
  
  xedge = width/2 - 50;
  yedge = height/2 - 50;
  
  for (int i = -xedge; i < xedge; i = i + stepSize) {
    ArrayList<PVector> col = new ArrayList<PVector>();
    for (int j = -yedge; j < yedge; j = j + stepSize) {
      col.add(new PVector(float(i), float(j)));     // add + 0.000001 to avoid 1/r error (map function) 
    }
    grid.add(col);
  }
  image = mapping(grid);
  animation = generateFrame(grid, image);
 
}

void draw() {
  background(0);
  strokeWeight(2);
  noFill();
  if (status == GRID_DISPLAY) {
    for(ArrayList<PVector> column:grid){
      float col = map(column.get(0).x,-xedge,xedge,0,255);
      colorList.append(col);
      stroke(col, 255, 255);
      beginShape();
      for(PVector v:column){
        vertex(v.x, v.y);
      }
      endShape();
    }

    for (int i = 0; i < grid.get(0).size(); ++i) {
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < grid.size(); ++j) {
        PVector v = grid.get(j).get(i);
        vertex(v.x, v.y);
      }
      endShape();
    }
  } else if (status == IMG_DISPLAY) {
    for (int i = 0; i < image.size(); ++i) {
      ArrayList<PVector> column = image.get(i);
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for(PVector v:column){
        vertex(v.x, v.y);
      }
      endShape();
    }
    for (int i = 0; i < image.get(0).size(); ++i) {
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < image.size(); ++j) {
        PVector v = image.get(j).get(i);
        vertex(v.x, v.y);
      }
      endShape();
    }
  } else if (status == ANIMATION_DISPLAY){
    for (int i = 0; i < animation.size(); ++i) {
      ArrayList<ArrayList<PVector>> column = animation.get(i);
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < column.size(); ++j) {
        ArrayList<PVector> list = column.get(j);
        PVector v = list.get(currentFrame);
        vertex(v.x, v.y);
      }
      endShape();
    }
    for (int i = 0; i < animation.get(0).size(); ++i) {
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < animation.size(); ++j) {
        PVector v = animation.get(j).get(i).get(currentFrame);
        vertex(v.x, v.y);
      }
      endShape();
    }
    currentFrame++;
    if (currentFrame == no_of_Frames-1) {
      status = IMG_DISPLAY;
    }
  } else if (status == REVERSE_ANIMATION_DISPLAY){
    for (int i = 0; i < animation.size(); ++i) {
      ArrayList<ArrayList<PVector>> column = animation.get(i);
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < column.size(); ++j) {
        ArrayList<PVector> list = column.get(j);
        PVector v = list.get(currentFrame);
        vertex(v.x, v.y);
      }
      endShape();
    }
    for (int i = 0; i < animation.get(0).size(); ++i) {
      stroke(colorList.get(i), 255, 255);
      beginShape();
      for (int j = 0; j < animation.size(); ++j) {
        PVector v = animation.get(j).get(i).get(currentFrame);
        vertex(v.x, v.y);
      }
      endShape();
    }
    currentFrame--;
    if (currentFrame == 0) {
      status = GRID_DISPLAY;
    }
  }
}

void mouseClicked() {
  if (status == GRID_DISPLAY) {
    status = ANIMATION_DISPLAY;
  } else if(status == IMG_DISPLAY){
    status = REVERSE_ANIMATION_DISPLAY;
  }
}
