//
//  ViewController.m
//  ChuckNorrisJokes
//
//  Created by JerryTaylorKendrick on 5/4/13.
//  Copyright (c) 2013 DeanAMH. All rights reserved.
//

#import "ViewController.h"
#import "JokeViewController.h"



// Preferred networking framework for URL processing
#import "AFNetworking.h"

@interface ViewController ()

@property (nonatomic, strong) Joke *joke;



@end

@implementation ViewController

@synthesize fliteController;
@synthesize slt;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // The following code is added to allow swipe recognition int the Guessingcat View Controller:
    //    - Right Swipe for next view (JokeViewController)
    //    - Left Swipe no action
    //    - Up Swipe - no action
    //    - Down Swipt - no action
    
    self.swipeJokesRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuessingCatSwipes:)];
    self.swipeJokesRight.direction = UISwipeGestureRecognizerDirectionRight;
    // I think the line below accomplishes the same as above (?)
    //[_swipeJokesRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:self.swipeJokesRight];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getJokeButton:(id)sender {
    
    // Pass the URL to the method that will return a randowm Chuck Norris joke"
    NSLog(@"%@", [[Joke alloc] isFound:@"http://api.icndb.com/jokes/random" ]);

}


- (IBAction) handleJokeSwipes:(UIGestureRecognizer *) sender {
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *) sender direction];
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"up");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"down");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"left");
            //[self.navigationController popViewControllerAnimated:YES];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"right");
            JokeViewController *jokeViewController = [[JokeViewController alloc]  initWithNibName:@"JokeViewController"
                                                                                           bundle:nil];
            [self.navigationController pushViewController:jokeViewController animated:YES];
            break;
    }
}


// ***********************************************************************************************
// * The Following two methods implement the "Lazy" getters used by the Open Ears TTS Framework  *
// ***********************************************************************************************
- (FliteController *)fliteController {
	if (fliteController == nil) {
		fliteController = [[FliteController alloc] init];
	}
	return fliteController;
}


- (Slt *)slt {
	if (slt == nil) {
		slt = [[Slt alloc] init];
	}
	return slt;
}


@end
