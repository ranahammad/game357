//
//  Game_357ViewController.h
//  Game_357
//
//  Created by Rana Hammad Hussain on 6/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface Game_357ViewController : UIViewController {
	GameView *gameView;
	UIImageView *imageView;
	UIView* optionView;
	UIView* playerOptionView;
	NSInteger m_iGameSelected;
}

@property (nonatomic, retain) IBOutlet UIView *playerOptionView;
@property (nonatomic, retain) IBOutlet UIView *optionView;
@property (nonatomic, retain) IBOutlet GameView *gameView;
@property (nonatomic, retain) UIImageView *imageView;

-(IBAction) Game357BtnClicked;
-(IBAction) Game579BtnClicked;
-(IBAction) onePlayerBtnClicked;
-(IBAction) twoPlayerBtnClicked;
-(IBAction) infoBtnClicked;
-(void) updateMainViewDelegateMethod:(id) sender;

@end

