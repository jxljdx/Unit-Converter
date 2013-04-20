//
//  LengthViewController.h
//  Unit-Converter
//
//  Created by Jundong Liao on 4/18/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface LengthViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)clearInput:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *choice1;
@property (strong, nonatomic) IBOutlet UITextField *input1;
@property (strong, nonatomic) IBOutlet UILabel *choice2;
@property (strong, nonatomic) IBOutlet UITextField *input2;

@property (strong, nonatomic) IBOutlet UILabel *choice3;
@property (strong, nonatomic) IBOutlet UITextField *input3;
@property (strong, nonatomic) IBOutlet UILabel *choice4;
@property (strong, nonatomic) IBOutlet UITextField *input4;

@property(nonatomic,strong) NSArray *lengthUnits;

@end
