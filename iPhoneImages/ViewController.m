//
//  ViewController.m
//  iPhoneImages
//
//  Created by Yongwoo Huh on 2018-02-01.
//  Copyright © 2018 YongwooHuh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self randomizeImage:self.randomizeButton];
    
   
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)randomizeImage:(UIButton *)sender {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.waitsForConnectivity = YES;
    configuration.allowsCellularAccess = NO;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // change url
    
    NSMutableURLRequest *request = [self changeiPhoneImage];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image;
        }];
        
    }];
    
    [task resume];
    [self.view setNeedsDisplay];
}

- (NSMutableURLRequest *)changeiPhoneImage
{
    NSURL *roseGold = [NSURL URLWithString:@"https://i.imgur.com/y9MIaCS.png"];
    NSURL *jetBlack = [NSURL URLWithString:@"https://i.imgur.com/zdwdenZ.png"];
    NSURL *black = [NSURL URLWithString:@"https://i.imgur.com/bktnImE.png"];
    NSURL *gold = [NSURL URLWithString:@"https://i.imgur.com/CoQ8aNl.png"];
    NSURL *sliver = [NSURL URLWithString:@"https://i.imgur.com/2vQtZBb.png"];
    
    NSArray<NSURL *> *urls = @[roseGold, jetBlack, black, gold, sliver];
    NSURL *url = urls[arc4random_uniform((int)urls.count)];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    return request;
}

@end
