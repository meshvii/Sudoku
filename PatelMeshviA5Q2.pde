/*Meshvi Pramodbhai Patel
  PATMD2003
  COMP1010 Assignment-5 */
import javax.swing.JOptionPane;
int gridRow=9; // to store the number of rows and columns
int[] arrBlue=new int [81]; //array to hold the values that are provided by the computer
int[] arrBlack=new int [81]; //array to hold the values provided by the user
int[] gridValues={2,12,25,42,50,73,4,9,24,28,59,74,6,13,41,75, //array to hold the cellnumbers fot the values provided by computer
                  11,30,45,69,14,26,39,47,58,79,16,19,29,80,17,
                  31,68,23,35,36,49,64};
char text=' ';  //variable to store the input provided by the user

void setup() {
  size(500, 500);
}

void draw() {
  background(200);
  drawGrid();  
  arrBlue=arrBlue(arrBlue);  
  printBlue(arrBlue);
  printBlack(arrBlack);
  winArr(arrBlue,arrBlack);
  
}

/****************************************/

void drawGrid() {  //function to draw Sudoku grid
  noFill();
  strokeWeight(1);
  int rectWidth=width/gridRow;
  int rectHeight=height/gridRow;
     for (int i=0; i<gridRow; i++)       //loop to draw grids for numbers
          {
             for (int j=0; j<gridRow; j++)
                 {
                  rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
                 }
          } 
    for (int k=0; k<=gridRow; k+=3)      //loop to draw borders for the sub-grids
        {  
         strokeWeight(10);
         line(k*rectWidth, 0, k*rectWidth, height);
         line(0, k*rectWidth, width, k*rectWidth);
        }
}
/*****************************************************/
int gridCellNum(int i, int j) { // function to return cellnumber for individual value on the Sudoku
  int cellNum=(i+j)+(gridRow-1)*j;
  return cellNum;
}

/*****************************************************/
int[]  arrBlue(int[] arr1) {  //function to assign values to the array that are already provided by the computer
  
    int gridCellnum=0;
    for (int i=0; i<gridRow; i++) 
        {
         for (int j=0; j<gridRow; j++)
             {
              gridCellnum=gridCellNum(i,j);
              arr1[gridCellnum]=assignBlueValue(gridCellnum);
             }
       }
     return arr1;
  
}

/***************************************************/
int assignBlueValue(int gridno) {    //function used to return specific value as per its cell's position
  int value=0;
  if (gridno==2 || gridno==12 || gridno==25 || gridno==42 || gridno==50 || gridno==73)
    value=2;
  else if (gridno==4 || gridno==9 || gridno==24 || gridno==28 || gridno==59 || gridno==74)
    value=8;
  else if (gridno==6 || gridno==13 || gridno==41 ||  gridno==75)
    value=5;
  else if (gridno==11 || gridno==30 || gridno==45 || gridno==69)
    value=1;
  else if (gridno==14 || gridno==26 || gridno==39 || gridno==47 || gridno==58 || gridno==79)
    value=7;
  else if (gridno==16 || gridno==19 || gridno==29 || gridno==80)
    value=4;
  else if (gridno==17 || gridno==31 || gridno==68)
    value=9;
  else if (gridno==23 || gridno==35 || gridno==36 || gridno==49)
    value=3;
  else if (gridno==64)
    value=6;

  return value;
}

/************************************************************/

void printBlue(int [] arr) { //function to print exisiting values provided by computer onto the canvas 
  float rectWidth=width/gridRow;
  float addX, addY;
  String text;
  for (int i=0; i<gridRow; i++)
  {
    for (int j=0; j<gridRow; j++)
    {
      fill(0, 0, 255);
      addX=i*rectWidth+rectWidth/2-5;
      addY=j*rectWidth+rectWidth/2+5;
      if (arr[gridCellNum(i, j)]==0)
        text="";
      else
        text=str(arr[gridCellNum(i, j)]);
        text(text, addX, addY);
    }
  }
}
/***************************************************************************/

void mouseClicked(){
  inputCondition(); 
}
/*************************************************************************/

void inputCondition(){  //fucntion that checks the value provided by user with it's row, column and sub-grid
 
 int gridCellNum=0;
 int rectWidth=width/gridRow;
 int rectHeight=rectWidth;
 int value=0;
 int [] getRowNum=new int [2];
 int getColumnNum=0;
 int count=0;
 int gridCellTemp=0;
 value=int(text)-int('0');
                      
 
      if( (int(text)>=48 && int(text)<=57 ) || (text=='c' || text=='C' ) ){
          for(int i=0;i<gridRow;i++)
          {
             for(int j=0;j<gridRow;j++)
                 {
                  if(mouseX>i*rectWidth && mouseX<(i+1)*rectWidth &&
                   mouseY>j*rectHeight && mouseY<(j+1)*rectHeight )  
                    {
                      gridCellNum=gridCellNum(i,j);
                      getRowNum=getRowNum(i,j);
                      getColumnNum=getColumnNum(i,j);
                      gridCellTemp=checkSubGrid(i,j);  
                      
                                                 for(int p=0;p<37;p++) // loop  whether to check user is trying to changing the values provided by the computer
                                                 {
                                                   if(gridCellNum==gridValues[p])
                                                   JOptionPane.showMessageDialog(frame,"You can't modify the provided numbers by the computer");
                                                   
                                                 }  
                                  
                                                if(text=='c' || text=='C') //condition for erasing a value
                                                  {
                                                   arrBlack[gridCellNum]=0;
                                                   printBlack(arrBlack);            
                                                  } 
                                                else{
                                                       if(arrBlack[gridCellNum]==0 && arrBlue[gridCellNum]==0)
                                                          {  
                                                           for(int k=getRowNum[0];k<=getRowNum[1];k++)   //loop to check row's condition
                                                           if(arrBlue[k]==value || arrBlack[k]==value)
                                                           count++; 
                                                           for(int l=getColumnNum;l<=(getColumnNum+72);l+=9) //loop to check column's condition
                                                           if(arrBlue[l]==value || arrBlack[l]==value)
                                                           count++;
                                                           for(int m=gridCellTemp;m<(gridCellTemp+27);m+=9) //loop to check sub-grid's condition
                                                              {
                                                                for(int n=0;n<3;n++)
                                                                if(arrBlue[m+n]==value || arrBlack[m+n]==value)
                                                                count++;
                                                              }  
                                               
                                                         if(count==0)
                                                          {
                                                           arrBlack[gridCellNum]=value;
                                                           printBlack(arrBlack);            
                                                          }
                                                        else
                                                        JOptionPane.showMessageDialog(frame," You are only allowed to enter a unique digit(1-9) in a row, column or block!. I did not let you enter "+key);
                                                      }
                                                  }              
                                      } 
                              }
                 }
        } 
}

/*******************************************************/
void keyPressed(){
 
 text=key;
 if( (int(text)>=48 && int(text)<=57 )|| (text=='c' || text=='C'))
 {
    println(" Typed Character :"+ text);
    if( text=='c' || text=='C' )
    println(" Click the number you want to erase ");
    else
    println("Please click the cell where you want to insert this value");
 }
 else
 println(" You are only allowed to enter a digit (1-9)");

}

/***************************************************/

void printBlack(int[] arrBlack) //function to print values provided by the user
{
  float rectWidth=width/gridRow;
  float addX,addY;
  textSize(width/50);
  for (int i=0; i<gridRow; i++)
  {
    for (int j=0; j<gridRow; j++)
    {
      fill(0);
      addX=i*rectWidth+rectWidth/2-5;
      addY=j*rectWidth+rectWidth/2+5;
      if (arrBlack[gridCellNum(i, j)]==0)
      text(' ', addX, addY);
      else
      text(( arrBlack[gridCellNum(i, j)]), addX, addY);
    }
  }
} 
/************************************************************/
 int[] getRowNum(int i,int j){  //funtion to return an array that consits the starting row no. and last row no. for the as per user's input
    int[] getRowNum= new int [2];
     
      getRowNum[0]=gridCellNum(i,j)-gridCellNum(i,j)%gridRow;
      getRowNum[1]=gridCellNum(i,j)-gridCellNum(i,j)%gridRow+(gridRow-1);
   return getRowNum;
   
 }  
  
/*********************************************************/
int getColumnNum(int i,int j){ // function to return the starting cell no. (in terms of column) as per user's input
  int getColumnNum=0;
  getColumnNum=gridCellNum(i,j)%gridRow;
  return getColumnNum; 
  
}
  
/*******************************************************************/

int checkSubGrid(int i,int j){ //function to return the starting cellno. for specific sub-grid as per user's input 
  int gridCellNum=0;
  if(j>=0 && j<=2)
    {
      if(i>=0 && i<=2)
      gridCellNum=0;
      else if(i>=3 && i<=5)
      gridCellNum=3;
      else if(i>=6 && i<=8)
      gridCellNum=6;
    }
  else if(j>=3 && j<=5)
   {
      if(i>=0 && i<=2)
      gridCellNum=27;
      else if(i>=3 && i<=5)
      gridCellNum=30;
      else if(i>=6 && i<=8)
      gridCellNum=33;
   }
   else if(j>=6 && j<=8)
   {
     if(i>=0 && i<=2)
      gridCellNum=54;
      else if(i>=3 && i<=5)
      gridCellNum=57;
      else if(i>=6 && i<=8)
      gridCellNum=60;
   
   }  
    return gridCellNum;
}  

 /*********************************************************************************/
 
 void winArr(int[] arrBlue, int[] arrBlack){  //function to detect whether user has successfully filled each cell and with all rules followed and to declare it as a WIN
   int[] winArray=new int [81];
   int count=0;
   for(int i=0;i<81;i++){
     
    if(arrBlue[i]==0)
    winArray[i]=arrBlack[i];
    else
    winArray[i]=arrBlue[i];      
   }
   
   for(int j=0;j<81;j++)
   {
     if(winArray[j]==0)
     count=1;
   }  
   
   if(count==0)
   JOptionPane.showMessageDialog(frame,"Congratulations! You Won ");
   
 }
/*****************************************************************************/ 
