//
//  Game_357AppDelegate.m
//  Game_357
//
//  Created by Rana Hammad Hussain on 6/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Game_357AppDelegate.h"
#import "Game_357ViewController.h"

@implementation Game_357AppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
