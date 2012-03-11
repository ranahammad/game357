//
//  GameEngine.m
//  Game_357
//
//  Created by Rana Hammad Hussain on 04/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameEngine.h"


@implementation GameEngine

@synthesize lineRows;
@synthesize cutLines;
@synthesize rows;
@synthesize cols;
@synthesize cutCount;
@synthesize redTurn;
@synthesize gameState;


- (void)initialize:(NSInteger)_rows Columns:(NSInteger) _startingColumns {

	rows  = _rows;
	cols  = _startingColumns;
	
	if  (lineRows != nil)
	{
		[lineRows removeAllObjects];
		[lineRows release];
	}
		
	if (cutLines != nil)
	{
		[cutLines removeAllObjects];
		[cutLines release];
	}
	
	lineRows = [[NSMutableArray alloc] initWithCapacity:rows];
	cutLines = [[NSMutableArray alloc] init];
	redTurn = TRUE;
	
	cutCount = 0;
	int minRowDistance = MIN_ROW_DISTANCE;
	int lineHeight = (SCREEN_HEIGHT - MIN_ROW_DISTANCE * (rows + 1)) / rows;
	for (int i=0; i < rows; i++)
	{
		NSInteger tempCols = cols + (i * 2);
		NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:tempCols];
		//	int centerCol = tempCols/2 + 1;
		int minColDistance = SCREEN_WIDTH / 2 - (tempCols / 2 * MIN_COL_DISTANCE);
		
		//		int soace
		for (int j=0; j < tempCols; j++)
		{
			Line *newLine = [[Line alloc] init];
			newLine.row = i;
			newLine.col = j;
			newLine.lineState = stateUnTouched;
			int x = minRowDistance;
			int y = minColDistance;
			[newLine set_p1:CGPointMake(y, x)];
			
			x += lineHeight;
			[newLine set_p2:CGPointMake(y, x)];
			
			[newArray addObject:newLine];
			minColDistance += MIN_COL_DISTANCE;
			
		}
		minRowDistance += lineHeight + MIN_ROW_DISTANCE;
		
		[lineRows addObject:newArray];
	}	
}

- (bool)checkValidMove: (int) x1 : (int) y1 : (int) x2 : (int) y2 {
	Line *tempCutLine = [[Line alloc] init];

	[tempCutLine set_p1:CGPointMake(x1, y1)];
	[tempCutLine set_p2:CGPointMake(x2, y2)];

	NSMutableArray *gameLines = self.lineRows;
	int firstRow = -1;
	int prevCol = -1;
	bool touched = FALSE;
	for (int i=0; i < self.rows; i++)
	{	
		NSMutableArray *gameLine = [gameLines objectAtIndex:i];
		int tempCols = self.cols + (i * 2);
		
		for (int j=0; j < tempCols; j++)
		{
			Line *tempLine = [gameLine objectAtIndex:j];
			if([self linesIntersect:tempLine :tempCutLine] == YES)
			{
				touched = TRUE;
				if(tempLine.lineState == stateUnTouched)
				{
					if(firstRow == -1)
					{
						firstRow = tempLine.row;
					}
				
					if(firstRow == tempLine.row)
					{
						if(prevCol == -1)
						{
							prevCol = tempLine.col;
							continue;
						}
					
						if(prevCol == (tempLine.col - 1))
						{
							prevCol = tempLine.col;
							continue;
						}
					}
				}
				return NO;
			}
		}
	}
	return touched;
}

- (bool)sameSign: (int) num1 : (int) num2 {
		if (num1 == 0)
			num1 = 1;
		if (num2 == 0)
			num2 =1;
	
	return (num1/abs(num1) == num2/abs(num2));
}

- (bool)linesIntersect: (Line *)line1 : (Line *)line2 {
	
	int x1 = line1._p1.x;
	int y1 = line1._p1.y;
	int x2 = line1._p2.x;
	int y2 = line1._p2.y;
	
	int x3 = line2._p1.x;
	int y3 = line2._p1.y;
	int x4 = line2._p2.x;
	int y4 = line2._p2.y;
	
	long Ax,Bx,Cx,Ay,By,Cy,d,e,f,num,offset,x,y;
	short x1lo,x1hi,y1lo,y1hi;
	
	Ax = x2-x1;
	Bx = x3-x4;
	
	if(Ax<0) {						/* X bound box test*/
		x1lo=(short)x2; x1hi=(short)x1;
	} else {
		x1hi=(short)x2; x1lo=(short)x1;
	}
	if(Bx>0) {
		if(x1hi < (short)x4 || (short)x3 < x1lo) return NO;
	} else {
		if(x1hi < (short)x3 || (short)x4 < x1lo) return NO;
	}
	
	Ay = y2-y1;
	By = y3-y4;
	
	if(Ay<0) {						/* Y bound box test*/
		y1lo=(short)y2; y1hi=(short)y1;
	} else {
		y1hi=(short)y2; y1lo=(short)y1;
	}
	if(By>0) {
		if(y1hi < (short)y4 || (short)y3 < y1lo) return NO;
	} else {
		if(y1hi < (short)y3 || (short)y4 < y1lo) return NO;
	}
	
	
	Cx = x1-x3;
	Cy = y1-y3;
	d = By*Cx - Bx*Cy;					/* alpha numerator*/
	f = Ay*Bx - Ax*By;					/* both denominator*/
	if(f>0) {						/* alpha tests*/
		if(d<0 || d>f) return NO;
	} else {
		if(d>0 || d<f) return NO;
	}
	
	e = Ax*Cy - Ay*Cx;					/* beta numerator*/
	if(f>0) {						/* beta tests*/
		if(e<0 || e>f) return NO;
	} else {
		if(e>0 || e<f) return NO;
	}
	
	/*compute intersection coordinates*/
	
	if(f==0) return NO;
	num = d*Ax;						/* numerator */
	
	offset = ([self sameSign:num :f] == YES) ? f/2 : -f/2;		/* round direction*/
	x = x1 + (num+offset) / f;				/* intersection x */
	
	num = d*Ay;
	offset = ([self sameSign:num :f] == YES) ? f/2 : -f/2;
	y = y1 + (num+offset) / f;				/* intersection y */
	
	return YES;
}

- (void) checkGameStatus {
	NSMutableArray *gameLines = self.lineRows;
	int untouchedLinesCount = 0;
	for (int i=0; i < self.rows; i++)
	{	
		NSMutableArray *gameLine = [gameLines objectAtIndex:i];
		int tempCols = self.cols + (i * 2);
		
		for (int j=0; j < tempCols; j++)
		{
			Line *tempLine = [gameLine objectAtIndex:j];
			if (tempLine.lineState == stateUnTouched)
				untouchedLinesCount++;
		}
	}

	if (untouchedLinesCount == 0)
	{
		if (redTurn == TRUE)
		{
			[self setGameState:stateBlueWins];
		}
		else
		{
			[self setGameState:stateRedWins];		
		}
	}
	else if (untouchedLinesCount == 1)
	{
		if (redTurn == TRUE)
		{
			[self setGameState:stateRedWins];		
		}
		else
		{
			[self setGameState:stateBlueWins];
		}
	}
	else
		[self setGameState:stateUnfinished];		
}

- (void)addCutLine: (int) x1 : (int) y1 : (int) x2 : (int) y2 {
	Line *tempCutLine = [[Line alloc] init];
	
	[tempCutLine set_p1:CGPointMake(x1, y1)];
	[tempCutLine set_p2:CGPointMake(x2, y2)];
	
	NSMutableArray *gameLines = self.lineRows;
	for (int i=0; i < self.rows; i++)
	{	
		NSMutableArray *gameLine = [gameLines objectAtIndex:i];
		int tempCols = self.cols + (i * 2);
		
		for (int j=0; j < tempCols; j++)
		{
			Line *tempLine = [gameLine objectAtIndex:j];
			if([self linesIntersect:tempLine :tempCutLine] == YES)
			{
				if (redTurn == TRUE)
				{
					[tempLine setLineState:stateRedTouched];
				}
				else
				{
					[tempLine setLineState:stateBlueTouched];
				}
			}
		}
	}
	if (redTurn == TRUE)
	{
		[tempCutLine setLineState:stateRedCutLine];
	}
	else
	{
		[tempCutLine setLineState:stateBlueCutLine];
	}
	
	[self.cutLines addObject:tempCutLine];
	self.cutCount++;
	
	redTurn = !redTurn;
	[self checkGameStatus];
}

@end
