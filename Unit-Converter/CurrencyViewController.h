//
//  CurrencyViewController.h
//  Unit-Converter
//
//  Created by Jundong Liao on 4/18/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface CurrencyViewController : UIViewController<NSXMLParserDelegate>
- (IBAction)clearInput:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *choice1;
@property (strong, nonatomic) IBOutlet UITextField *input1;
@property (strong, nonatomic) IBOutlet UILabel *choice2;
@property (strong, nonatomic) IBOutlet UITextField *input2;
@property (strong, nonatomic) IBOutlet UILabel *choice3;
@property (strong, nonatomic) IBOutlet UITextField *input3;
@property (strong, nonatomic) IBOutlet UILabel *choice4;
@property (strong, nonatomic) IBOutlet UITextField *input4;
@property (strong, nonatomic) IBOutlet UIView *pickerTrans;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)bgTapped:(id)sender;
- (IBAction)convert:(id)sender;

@property (strong, nonatomic) NSArray *curUnits;

@property (strong, nonatomic) NSMutableDictionary *currency;
@property (strong, nonatomic) NSUserDefaults* userDefaults;

@end
