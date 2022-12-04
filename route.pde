class Route{
  int[] path = new int[nPoints];
  
  Route(){
    path = new int[nPoints];
    for(int i = 0; i  < nPoints; i++)
      path[i] = i;
  }
  
  Route(int[] path){
    arrayCopy(path, this.path);
  }
  
  void draw(){
    noFill();
    stroke(220, 40, 120);
    for(int i = 1; i  < nPoints; i++){
      PVector from = points[path[i - 1]];
      PVector to = points[path[i]];
      line(from.x, from.y, to.x, to.y);
    }
  }
  
  int calculateLength(){
    int sum = 0;
    for(int i = 1; i  < nPoints; i++)
      sum += distance(path[i - 1], path[i]);
    
    return sum;
  }
}

float distance(int a, int b){
  PVector from = points[a];
  PVector to = points[b];
  return dist(from.x, from.y, to.x, to.y);
}

Route generateNewRoute(int startIndex){
  int[] path = new int[nPoints];
  path[0] = startIndex;
  ArrayList<Integer>usedSpots = new ArrayList<Integer>();
  usedSpots.add(startIndex);
  for(int i = 1; i < nPoints; i++){
    path[i] = nextPoint(path[i - 1], usedSpots);
    usedSpots.add(path[i]);
  }
  
  Route route = new Route(path);
  
  return route;
}

int nextPoint(int currentIndex, ArrayList<Integer>usedSpots){
  if(usedSpots.size() >= nPoints)
    return -1;
  
  int[] possibleNextPoints = new int[nPoints - usedSpots.size()];
  int arrayIndex = 0;
  float[] weights = new float[nPoints - usedSpots.size()];
  float sumWeight = 0;
  for(int i = 0; i < nPoints; i++){
    if(usedSpots.contains(i))
      continue;
    
    possibleNextPoints[arrayIndex] = i;
    weights[arrayIndex] = pow(1.0 / distance(currentIndex, i), 3);
    sumWeight += weights[arrayIndex];
    arrayIndex++;
  }
  
  float diceRoll = random(sumWeight);
  float summedWeights = 0;
  for(int i = 0; i < weights.length; i++){
    summedWeights += weights[i];
    if(diceRoll <= summedWeights){
      return possibleNextPoints[i];
    }
  }
  
  return -1;
}
