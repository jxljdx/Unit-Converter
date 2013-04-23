//
//  TopViewController.h
//  Unit-Converter
//
//  Created by Jundong Liao on 4/23/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface TopViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *choice1;
@property (weak, nonatomic) IBOutlet UILabel *choice2;
@property (weak, nonatomic) IBOutlet UILabel *choice3;
@property (weak, nonatomic) IBOutlet UILabel *choice4;
@property (weak, nonatomic) IBOutlet UITextField *input1;
@property (weak, nonatomic) IBOutlet UITextField *input2;
@property (weak, nonatomic) IBOutlet UITextField *input3;
@property (weak, nonatomic) IBOutlet UILabel *input4;
@property (weak, nonatomic) IBOutlet UIView *pickerTrans;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray* units;
@property (strong, nonatomic) NSDictionary* unitMap;
@property (strong, nonatomic) NSString* classification;   // Current unit classification

- (IBAction)revealMenu:(id)sender;
- (IBAction)clearInput:(id)sender;
- (IBAction)convert:(UITextField *)sender;
- (IBAction)bgTapped:(id)sender;

@end
