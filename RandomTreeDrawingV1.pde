import java.util.ArrayList;

int wid = 600;
int hei = 600;

int treeHeight = (int)random(0, hei * 1/4);

float branchX1 = wid/2;
float branchY1;

float leftBranchX2;
float leftBranchY2;

float rightBranchX2;
float rightBranchY2;

int hLengthMin = 70;
int hLengthMax = 150;
int vLengthMin = 20;
int vLengthMax = 30;

float leafX;
float leafY;

float leafIncrement;

float branchSlope;

ArrayList<int[]> treeColors = new ArrayList<int[]>();


public void setup()
{
  surface.setSize(wid, hei);
  background(53, 81, 92);
  surface.setLocation((1920/2) - (width/2), (1080/2) - (height/2));
  
  treeColors.add(new int[]{160, 128, 81});
  treeColors.add(new int[]{147, 98, 25});
  treeColors.add(new int[]{152, 121, 81});
  
  //noLoop();
}

public void draw()
{
  background(53, 81, 92);
  drawTree();
  delay(3000);
  
  //System.out.println("ALL DONE");
}

public void drawTree()
{
  int colorChoice = (int)random(0, treeColors.size());
  
  int treeR = treeColors.get(colorChoice)[0];
  int treeG = treeColors.get(colorChoice)[1];
  int treeB = treeColors.get(colorChoice)[2];
  
  strokeWeight(10);
  stroke(treeR, treeG, treeB);
  line(wid/2, hei, wid/2, treeHeight);
  
  for(int i = 0; i < random(50, 100); i++)
  {
    //System.out.println("\nBranch Number: " + i);
    
    int leftOrRight = (int)random(0, 2);
    
    branchY1 = random(treeHeight + 20, height - 50);
    
    //System.out.println(leftOrRight);
    
    if (leftOrRight == 0)
    {
      //System.out.println("left branch");
      
      leftBranchX2 = branchX1 - random(hLengthMin, hLengthMax);
      leftBranchY2 = branchY1 - random(vLengthMin, vLengthMax);
      
      //System.out.println("x1: " + branchX1 + "\ty1: " + branchY1 + "\tleftX2: " + leftBranchX2 + "\tleftY2: " + leftBranchY2);
      
      branchSlope = ((leftBranchY2 - branchY1) / (leftBranchX2 - branchX1));
      //System.out.println(branchSlope);
      
      stroke(treeR, treeG, treeB);
      strokeWeight(3);
      line(branchX1, branchY1, leftBranchX2, leftBranchY2);
      
      leafX = branchX1 - 7;
      leafY = branchY1;
      
      for(int leafRow = 0; leafRow < 7; leafRow++)
      {
        while(leafX > leftBranchX2 - 10)
            {
              //System.out.println(leftBranchX2);
              
              fill(152, 224, 147);
              noStroke();
              ellipse((int)leafX, (int)random(leafY -3, leafY + 4), 9, 4);
              
              leafIncrement = random(40, 60);
              
              leafX -= leafIncrement * branchSlope;
              leafY -= leafIncrement * sq(branchSlope);
              
              //System.out.println((int)leafX + "\t" + (int)leafY);
            }
            //System.out.println("rows of leaves: " + (leafRow + 1));
      }
      
      //System.out.println("leaves done");
      
      
      
      
      //System.out.println(branchSlope);
    }
    else
    {
      //System.out.println("right branch");
      
      rightBranchX2 = branchX1 + random(hLengthMin, hLengthMax);
      rightBranchY2 = branchY1 - random(vLengthMin, vLengthMax);
      
      //System.out.println("x1: " + branchX1 + "\ty1: " + branchY1 + "\trightX2: " + rightBranchX2 + "\trightY2: " + rightBranchY2);
      
      branchSlope = ((rightBranchY2 - branchY1) / (rightBranchX2 - branchX1));
      //System.out.println(branchSlope);
      
      stroke(treeR, treeG, treeB);
      strokeWeight(3);
      line(branchX1, branchY1, rightBranchX2, rightBranchY2);
      
      leafX = branchX1 + 7;
      leafY = branchY1;
      
      for(int leafRow = 0; leafRow < 7; leafRow++)
      {
        while(leafX < rightBranchX2 + 10)
            {
              //System.out.println(rightBranchX2);
              
              fill(152, 224, 147);
              noStroke();
              ellipse((int)leafX, (int)random(leafY - 3, leafY + 4), 9, 4);
              
              leafIncrement = random(40, 60);
              
              leafX -= leafIncrement * branchSlope;
              leafY -= leafIncrement * sq(branchSlope);
              
              //System.out.println((int)leafX + "\t" + (int)leafY);
            }
            //System.out.println("rows of leaves: " + (leafRow + 1));
      }
      
      //System.out.println("leaves done");
      
      
      
      
      
      //System.out.println(branchSlope);
    }
  }
}


// x = (whatever increment) times the slope *** if slope is negative, make the x negative

// y = (whatever increment) times the square of the slope
