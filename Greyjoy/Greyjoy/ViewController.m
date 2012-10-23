//
//  ViewController.m
//  Greyjoy
//
//  Created by Dondi Sasmita on 23/10/12.
//  Copyright (c) 2012 donsdai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize urlField = urlField_, submitBtn = submitBtn_,
resultTextView = resultTextView_, respFormatSegment = respFormatSegment_;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtnDidTap:(id)sender{
    BaseAPIResponseFormat baseAPIFormat;
    switch (respFormatSegment_.selectedSegmentIndex) {
        case 0:
            baseAPIFormat = baseAPIFormatJSON;
            break;
            
        case 1:
            baseAPIFormat = baseAPIFormatXML;
            break;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:urlField_.text]];
    [request setHTTPMethod:@"GET"];
    
    NSString *header = [NSString stringWithFormat:@"application/vnd.bhg_rewards.v1"];
    [request setValue:header forHTTPHeaderField:@"Accept"];
    
    baseHttpApi_ = [[BaseHttpAPI alloc] initWithDictionary:nil
                                                  delegate:self];
    [baseHttpApi_ callAPI:request expectResponse:baseAPIFormat];
}

#pragma mark -
#pragma mark BaseHTTPAPI Delegate

- (void)baseHttpAPIDidReturnSuccessfully:(NSDictionary *)result{
    NSLog(@"%@",result);
    
}

- (void)baseHttpAPIDidReturnWithError:(NSError *)error{
    
}

@end
