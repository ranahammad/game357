//
//  GameEngine.h
//  Game_357
//
//  Created by Rana Hammad Hussain on 04/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"


#define SCREEN_WIDTH 480
#define SCREEN_HEIGHT 320
#define MIN_ROW_DISTANCE 30
#define MIN_COL_DISTANCE 40

@class Line;

typedef enum {
	stateUnfinished=0,
	stateRedWins,
	stateBlueWins
} GameState;

@interface GameEngine : NSObject {
	NSMutableArray *lineRows;
	NSMutableArray *cutLines;
	NSInteger cutCount;
	NSInteger rows;
	NSInteger cols;
	GameState gameState;
	bool redTurn;
}

@property (nonatomic, retain) NSMutableArray *lineRows;
@property (nonatomic, retain) NSMutableArray *cutLines;
@property (nonatomic) NSInteger rows;
@property (nonatomic) NSInteger cols;
@property (nonatomic) NSInteger cutCount;
@property (nonatomic) GameState gameState;
@property bool redTurn;

- (void)initialize:(NSInteger)_rows Columns:(NSInteger) _startingColumns;
- (bool)linesIntersect: (Line *)line1 : (Line *)line2;
- (bool)checkValidMove: (int) x1 : (int) y1 : (int) x2 : (int) y2;
- (bool)sameSign: (int) num1 : (int) num2;
- (void)addCutLine: (int) x1 : (int) y1 : (int) x2 : (int) y2;
- (void)checkGameStatus;

@end
