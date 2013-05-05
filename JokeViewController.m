//
//  JokeViewController.m
//  ChuckNorrisJokes
//
//  Created by JerryTaylorKendrick on 5/4/13.
//  Copyright (c) 2013 DeanAMH. All rights reserved.
//

#import "JokeViewController.h"
#import "AFNetworking.h"

@interface JokeViewController ()

@end

@implementation JokeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.swipeJokesLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleJokesSwipes:)];
    self.swipeJokesLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    // I think the line below accomplishes the same as above (?)
    //[_swipeJokesLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:self.swipeJokesLeft];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction) handleJokeImageSearch:(id)sender {
    [self.view endEditing:YES];
    
    NSString *imageSearchURL = [NSString stringWithFormat:@"http://imdbapi.org/?type=json&title=%@&limit=10", self.searchField.text ];
    NSString *encodedString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // Success Block code
        // This code is executed when a web service call is successful
        //NSLog(@"%@", JSON);
        self.movies = JSON;
        [self.IMDBTable reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // Failure Block code
        // This code is executed when a web service call doesn't work.
        NSLog(@"oops: %@", error);
        
    }];
    [operation start];
}


// A method to indicate how many rows are in the table represented by tableView
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger *) section {
    return self.images.count;
}

// Compensates for the Table View cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0;
}

// Place items into the cells in the table represented by tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    //    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    
    //    cell.textLabel.text = [movie valueForKey:@"title"];
    //    return cell;
    
    //
    UINib *nib = [UINib nibWithNibName:@"imageCell" bundle:[NSBundle mainBundle]];
    
    //  Returns an array of all the top level objects in the Movie View
    NSArray *array = [nib instantiateWithOwner:nil options: nil];
    imageCell *cell = [array lastObject];
    
    NSDictionary *jokeImage = [self.jokeImages objectAtIndex:indexPath.row];
    NSString *title = [movie valueForKey:@"title"];
    id year = [movie valueForKey:@"year"];
    
    cell.nameLabel.text = title;
    cell.yearLabel.text = [NSString stringWithFormat:@"%@", year];
    NSURL *posterURL = [NSURL URLWithString:[movie valueForKey:@"poster"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
    
    NSLog(@"about to load joke image");
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest: request success:^(UIImage *image){
        cell.imageView.image = image;
        [cell layoutSubviews];
    }];
    NSLog(@"joke image loaded");
    [operation start];
    
    return cell;
}





- (IBAction) handleJokesSwipes:(UIGestureRecognizer *) sender {
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
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            // The statements below are found in the ViewController.m for this application and allow this veiw to be
            // reached via a right swipe
            //NSLog(@"right");
            //JokeViewController *jokeViewController = [[JokeViewController alloc]  initWithNibName:@"JokeViewController"
            //                                                                               bundle:nil];
            //[self.navigationController pushViewController:jokeViewController animated:YES];
            break;
    }
}


@end
