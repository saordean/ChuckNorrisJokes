//
//  JokeViewController.h
//  ChuckNorrisJokes
//
//  Created by JerryTaylorKendrick on 5/4/13.
//  Copyright (c) 2013 DeanAMH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString imageSearchUrl;
@property (weak, nonatomic) NSString searchString;
@property (nonatomic, strong) IBOutlet UITableView *jokeTable;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeJokesLeft;
- (IBAction) handleJokesSwipes:(UIGestureRecognizer *) sender;


@end
