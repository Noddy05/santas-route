final int nPoints = 50;
PVector[] points = new PVector[nPoints];
Route optimalRoute = new Route();
float optimalLength;

void setup(){
  size(800, 800);
  generatePoints();
  optimalLength = optimalRoute.calculateLength();
}

void draw(){
  background(30);
  drawPoints();
  for(int i = 0; i < 500; i++){
    Route newRoute = generateNewRoute(int(random(nPoints)));
    float newLength = newRoute.calculateLength();
    if(newLength < optimalLength){
      optimalRoute = newRoute;
      optimalLength = newLength;
    }
  }
  optimalRoute.draw();
}

void generatePoints(){
  for(int i = 0; i  < nPoints; i++){
    points[i] = new PVector(random(width), random(height));
  }
}

void drawPoints(){
  fill(255);
  noStroke();
  for(int i = 0; i  < nPoints; i++){
    circle(points[i].x, points[i].y, 5);
  }
}
