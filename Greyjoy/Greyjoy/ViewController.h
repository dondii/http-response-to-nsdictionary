//
//  ViewController.h
//  Greyjoy
//
//  Created by Dondi Sasmita on 23/10/12.
//  Copyright (c) 2012 donsdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpAPI.h"

@interface ViewController : UIViewController <BaseHttpAPIDelegate>
{
    @private
    UITextField *urlField_;
    UIButton *submitBtn_;
    UITextView *resultTextView_;
    UISegmentedControl *respFormatSegment_;
    
    BaseHttpAPI *baseHttpApi_;
}

@property (nonatomic, strong) IBOutlet UITextField *urlField;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) IBOutlet UITextView *resultTextView;
@property (nonatomic ,strong) IBOutlet UISegmentedControl *respFormatSegment;

- (IBAction)submitBtnDidTap:(id)sender;

@end
