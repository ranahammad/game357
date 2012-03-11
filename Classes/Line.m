//
//  Line.m
//  Game_357
//
//  Created by Rana Hammad Hussain on 04/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Line.h"


@implementation Line

@synthesize row;
@synthesize col;
@synthesize lineState;
@synthesize _p1;
@synthesize _p2;


- (bool)dolineIntersect: (CGPoint) p1: (CGPoint) p2 {
	
	long x1 = self._p1.x;
	long y1 = self._p1.y;
	long x2 = self._p2.x;
	long y2 = self._p2.y;
	
	long x3 = p1.x;
	long y3 = p1.y;
	long x4 = p2.x;
	long y4 = p2.y;
	
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
	offset = (num/abs(num) == f/abs(f)) ? f/2 : -f/2;		/* round direction*/
	x = x1 + (num+offset) / f;				/* intersection x */
	
	num = d*Ay;
	offset = (num/abs(num) == f/abs(f)) ? f/2 : -f/2;
	y = y1 + (num+offset) / f;				/* intersection y */
	
	return YES;
}

@end
