import java.util.ArrayList;

int wid = 600;
int hei = 600;

// control the range of possible heights
int treeHeight;

// the first coordinate pair for branch lines. X is always the same (base of tree)
float branchX1 = wid/2;
float branchY1;

// second coordinate pair for branch lines for both left and right side branches
float leftBranchX2;
float leftBranchY2;
float rightBranchX2;
float rightBranchY2;

// this controls the range of possible branch lengths. hLength is how long it goes on x-axis, vLength is how high it goes on y-axis
int hLengthMin = 70;
int hLengthMax = 150;
int vLengthMin = 20;
int vLengthMax = 30;

// coordinate to draw ellipse at for a leaf. exact value is determined further down
float leafX;
float leafY;

// controls how much space is in between one leaf and the next. consequently also controls leaf amount
float leafIncrement;

// the slope ( (y2 - y1) / (x2 - x1) ) of any given branch drawn. used to calculate where to draw leaves
float branchSlope;

float leafWidth;
float leafHeight;

float leafYRange = 25;

ArrayList<int[]> treeColors = new ArrayList<int[]>();


public void setup()
{
  surface.setSize(wid, hei);
  background(53, 81, 92);
  surface.setLocation((1920/2) - (width/2), (1080/2) - (height/2)); // sets window to appear in middle of screen. for now only works on a 1920x1080 monitor

  treeColors.add(new int[]{160, 128, 81});
  treeColors.add(new int[]{147, 98, 25});
  treeColors.add(new int[]{152, 121, 81});
}

public void draw()
{
  background(53, 81, 92);
  drawTree();
  delay(3000);
}

// draws a tree base of random height, branches of random length and height, and random amount of leaves on each branch
public void drawTree()
{
  int colorChoice = (int)random(0, treeColors.size());

  int treeR = treeColors.get(colorChoice)[0];
  int treeG = treeColors.get(colorChoice)[1];
  int treeB = treeColors.get(colorChoice)[2];

  // set base thickness and color
  strokeWeight(10);
  stroke(treeR, treeG, treeB);

  // set tree height
  treeHeight = (int)random(0, hei * 1/4);

  // draw tree base
  line(wid/2, hei, wid/2, treeHeight);
  
  // this for loop draws a random number of branches in the given range
  for (int i = 0; i < random(50, 70); i++)
  {
    // this determines whether to draw current branch on the left side or right side. 0 = left, 1 = right
    int leftOrRight = (int)random(0, 2);

    // determines what height on the tree to draw current branch
    branchY1 = random(treeHeight + 20, height - 50);

    // branch will be drawn next
    
    // leftOrRight = 0, draws branch on left side
    if (leftOrRight == 0)
    {
      // sets second coordinate pair for branch using the range defined above by hLength and vLength
      leftBranchX2 = branchX1 - random(hLengthMin, hLengthMax);
      leftBranchY2 = branchY1 - random(vLengthMin, vLengthMax);

      // does the math to determine the slope of the current branch
      branchSlope = ((leftBranchY2 - branchY1) / (leftBranchX2 - branchX1));

      // sets branch color and thickness
      stroke(treeR, treeG, treeB);
      strokeWeight(3);
      
      // draws the branch
      line(branchX1, branchY1, leftBranchX2, leftBranchY2);
      
      // this for loop is supposed to draw 7 rows of leaves on each branch
      for (int leafRow = 0; leafRow < 7; leafRow++)
      {
        // sets the coordinate pair for the FIRST leaf on current branch. x - 7 is used to keep it from spawning on the base of the tree
        leafX = branchX1 - random(-5, 15);
        leafY = branchY1;
        
        // this while loop is what actually draws the leaves. condition: the x coordinate for the current leaf to be drawn
        // must be greater than the x coordinate for the outer branch point (leftBranchX2). x2 - 10 is used so that leaves
        // will be drawn just a little bit past the end of the branch so you don't always see a branch with a bare end.
        while (leafX > leftBranchX2 - 10)
        {
          // sets the color of the leaf and removes outline
          fill(152, 224, 147);
          noStroke();
          
          // sets a random width and height for leaves
          leafWidth = random(6, 9);
          leafHeight = random(4, 7);
          
          // draws the leaf. random() is used to draw the leaf at a random height in relation to the branch. gives the leaves more variation
          // instead of always drawing in a straight line with the branch
          ellipse((int)leafX, (int)random(leafY - leafYRange, leafY + (leafYRange + 1)), leafWidth, leafHeight);

          // sets the number to plug into equation to determine how much farther down the branch the next leaf should be drawn
          leafIncrement = random(40, 60);

          // determines the coordinate for the next leaf to be drawn at.
          // x is determined by: leafIncrement * branchSlope
          // y is determined by: leafIncrement * the square of the branch slope
          leafX -= leafIncrement * branchSlope;
          leafY -= leafIncrement * sq(branchSlope);
        }
      }
    }
    
    // else (leftOrRight = 1), draws branch on right side
    else
    {
      // sets second coordinate pair for branch using the range defined above by hLength and vLength
      rightBranchX2 = branchX1 + random(hLengthMin, hLengthMax);
      rightBranchY2 = branchY1 - random(vLengthMin, vLengthMax);

      // does the math to determine the slope of the current branch
      branchSlope = ((rightBranchY2 - branchY1) / (rightBranchX2 - branchX1));

      // sets branch color and thickness
      stroke(treeR, treeG, treeB);
      strokeWeight(3);
      
      // draws the branch
      line(branchX1, branchY1, rightBranchX2, rightBranchY2);

      // this for loop is supposed to draw 7 rows of leaves on each branch
      for (int leafRow = 0; leafRow < 7; leafRow++)
      {
        // sets the coordinate pair for the FIRST leaf on current branch. x + 7 is used to keep it from spawning on the base of the tree
        leafX = branchX1 + random(-5, 15);
        leafY = branchY1;
        
        // this while loop is what actually draws the leaves. condition: the x coordinate for the current leaf to be drawn
        // must be less than the x coordinate for the outer branch point (rightBranchX2). x2 + 10 is used so that leaves
        // will be drawn just a little bit past the end of the branch so you don't always see a branch with a bare end.
        while (leafX < rightBranchX2 + 10)
        {
          // sets the color of the leaf and removes outline
          fill(152, 224, 147);
          noStroke();
          
          // sets a random width and height for leaves
          leafWidth = random(6, 9);
          leafHeight = random(4, 7);
          
          // draws the leaf. random() is used to draw the leaf at a random height in relation to the branch. gives the leaves more variation
          // instead of always drawing in a straight line with the branch
          ellipse((int)leafX, (int)random(leafY - leafYRange, leafY + (leafYRange + 1)), leafWidth, leafHeight);

          // sets the number to plug into equation to determine how much farther down the branch the next leaf should be drawn
          leafIncrement = random(40, 60);

          // determines the coordinate for the next leaf to be drawn at.
          // x is determined by: leafIncrement * branchSlope
          // y is determined by: leafIncrement * the square of the branch slope
          leafX -= leafIncrement * branchSlope;
          leafY -= leafIncrement * sq(branchSlope);
        }
      }
    }
  }
}
