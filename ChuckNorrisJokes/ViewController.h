//
//  ViewController.h
//  ChuckNorrisJokes
//
//  Created by JerryTaylorKendrick on 5/4/13.
//  Copyright (c) 2013 DeanAMH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Joke.h"
#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>

@interface ViewController : UIViewController

// Added to support the Open Ears TTS framework
@property (strong, nonatomic) FliteController *fliteController;
@property (strong, nonatomic) Slt *slt;

// Added to allow for swiping
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeJokesRight;
// Added to handle the get joke button
- (IBAction)getJokeButton:(id)sender;
- (IBAction) handleJokeSwipes:(UIGestureRecognizer *) sender;

@end
