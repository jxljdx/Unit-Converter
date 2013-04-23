//
//  TopViewController.m
//  Unit-Converter
//
//  Created by Jundong Liao on 4/23/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()

@end

@implementation TopViewController
@synthesize choice1;
@synthesize choice2;
@synthesize choice3;
@synthesize choice4;
@synthesize input1;
@synthesize input2;
@synthesize input3;
@synthesize input4;
@synthesize classification;
@synthesize unitMap;
@synthesize units;
@synthesize picker;
@synthesize pickerTrans;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - life cycle

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Default setting
    self.units = [[NSArray alloc]initWithObjects: @"inch",@"foot",@"yard",@"meter",@"dm",@"cm",@"mm",@"km",@"mile",@"mil",@"point",@"line",@"pica",@"rod",nil];
    self.unitMap = [[NSDictionary alloc] initWithObjectsAndKeys:@"39.37",@"inch",@"3.2808",@"foot",@"1.0936",@"yard",@"1",@"meter",@"10",@"dm",@"100",@"cm",@"1000",@"mm",@"0.001",@"km",@"0.00062137",@"mile",@"39370",@"mil",@"2834.6",@"point",@"472.44",@"line",@"236.22",@"pica",@"0.19884",@"rod",nil];
    self.classification = @"Length";
    self.choice1.text = @"meter";
    self.choice2.text = @"inch";
    self.choice3.text = @"feet";
    self.choice4.text = @"yard";
    [self.picker selectRow:3 inComponent:0 animated:YES];
    [self.picker selectRow:0 inComponent:1 animated:YES];
    [self.picker selectRow:1 inComponent:2 animated:YES];
    [self.picker selectRow:2 inComponent:3 animated:YES];
    
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if((int)([UIScreen mainScreen].bounds.size.height) == 480){
        self.pickerTrans.transform = CGAffineTransformMakeScale(1.0f, 0.9f);
        CGPoint pos = self.pickerTrans.frame.origin;
        CGPoint newPos = CGPointMake(pos.x, pos.y + 9.5);
        self.pickerTrans.frame = CGRectMake(newPos.x, newPos.y, self.pickerTrans.frame.size.width, self.pickerTrans.frame.size.height);
    }
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChoice1:nil];
    [self setChoice2:nil];
    [self setChoice3:nil];
    [self setChoice4:nil];
    [self setInput1:nil];
    [self setInput2:nil];
    [self setInput3:nil];
    [self setInput4:nil];
    [self setPickerTrans:nil];
    [self setPicker:nil];
    [self setClassification:nil];
    [self setUnitMap:nil];
    [self setUnits:nil];
    [super viewDidUnload];
}

#pragma mark - actions

- (IBAction)revealMenu:(id)sender {
    [self bgTapped:nil];
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)clearInput:(id)sender {
    NSLog(@"units count = %d", self.units.count);
    self.input1.text = @"";
    self.input2.text = @"";
    self.input3.text = @"";
    self.input4.text = @"";
}

- (IBAction)bgTapped:(id)sender {
    [self.input1 resignFirstResponder];
    [self.input2 resignFirstResponder];
    [self.input3 resignFirstResponder];
    [self.input4 resignFirstResponder];
}

#pragma mark - picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.units count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    label=[[UILabel alloc] initWithFrame:CGRectMake(0,0,50,32)];
    label.backgroundColor=[UIColor clearColor];
    label.text=[self.units objectAtIndex:row];
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        self.choice1.text=[self.units objectAtIndex:row];
    }else if(component==1){
        self.choice2.text=[self.units objectAtIndex:row];
    }else if(component==2){
        self.choice3.text=[self.units objectAtIndex:row];
    }else{
        self.choice4.text=[self.units objectAtIndex:row];
    }
}

#pragma mark - convertion handling

- (IBAction)convert:(UITextField *)sender {
    
}

@end










