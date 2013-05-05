//
//  Joke.m
//  ChuckNorrisJokes
//
//  Created by JerryTaylorKendrick on 5/4/13.
//  Copyright (c) 2013 DeanAMH. All rights reserved.
//

#import "Joke.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define MAX_NUMBER_OF_JOKES 10


@interface Joke()
@property (strong, nonatomic) UIImage      *relatedImage;
@property (strong, nonatomic) NSString     *location;
@property (strong, nonatomic) NSString     *key;
@property (strong, nonatomic) NSData       *response;
@property (strong, nonatomic) NSURLRequest *theRequest;
@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSURL        *jokeUrl;
@property (strong, nonatomic) NSData       *jokeData;
@property (strong, nonatomic) NSString     *jokeText;

-(NSString *)isFound:(NSString *)jokeUrl;
-(void)isSpoken:(NSString *)jokeString;
-(UIImage *) getsImage:(NSString *)imageUrlString;

@end


@implementation Joke


-(NSString *) isFound:(NSString *)url {
  
    // URL string for the random Chuck Norris joke site
    //@"http://api.icndb.com/jokes/random";
    
    // URL string in encoded format
    NSString *encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // All variables required for the AFSJSONRequestOperation method
    _jokeUrl = [NSURL URLWithString:encodedString];
    _request = [NSURLRequest requestWithURL:_jokeUrl];
    _theRequest = [NSURLRequest requestWithURL:_jokeUrl];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    
    //NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    _response = [NSURLConnection sendSynchronousRequest: _theRequest returningResponse: &resp error: &err];
    if (_response == nil) {
        NSLog(@"The was problem accessing the Google Place data, try again");
    }
    /*  It was learned from error messages that the only content types accepted  by the site are:
        stated to be:
               "text/json",
               "application/json",
               "text/javascript"
        however only:
               "text/html" 
        works.
     */
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:self.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // Success Block code.  This code is executed when a web service call is successful
        NSLog(@"Successful AFSONRequestOperation call");
        //NSLog(@"%@", JSON);
        // Turn progress indicator off
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // Failure Block code.  This code is executed when a web service call doesn't work.
        NSLog(@"An AFJSON request error occurred: %@", error);
        // Turn progress indicator off
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [operation start];
    
    /*
     
     Example JSON data format from Chuck Norris joke site ( http://api.icndb.com/jokes/random ) :
     
     { "type": "success", "value":
     
        { "id": 207,
          "joke": "It is believed dinosaurs are extinct due to a giant meteor. That's true if you want to call Chuck Norris a giant meteor.",
          "categories": []
        }
     }

     */

    _jokeText = [NSString alloc];
    NSDictionary *jsonArray=[NSJSONSerialization JSONObjectWithData:_response options:NSJSONReadingMutableContainers error:&err];
    if (!jsonArray) {
        NSLog(@"Error parsing JSON data: %@", err);
    } else {
        _jokeText = [jsonArray valueForKeyPath:@"value.joke"];
        //NSLog(@"%@", _jokeText);
    }

    return _jokeText;
}


-(void) isSpoken:(NSString *)jokeText {
    
    
}

-(UIImage *) getsImage:(NSString *)ImageURL {
    
    self.relatedImage = [[UIImage alloc] init ];
    
    
    return self.relatedImage;
}



@end
