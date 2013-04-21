//
//  LengthViewController.m
//  Unit-Converter
//
//  Created by Jundong Liao on 4/18/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import "LengthViewController.h"

@interface LengthViewController ()

@end

@implementation LengthViewController

@synthesize lengthUnits;
@synthesize choice1;
@synthesize choice2;
@synthesize choice3;
@synthesize choice4;
@synthesize input1;
@synthesize input2;
@synthesize input3;
@synthesize input4;

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
	// Do any additional setup after loading the views
    
    self.lengthUnits=[[NSArray alloc]initWithObjects: @"inch",@"feet",@"yard",@"km",@"meter",@"cm",nil];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

-(void)viewDidUnload
{
    [self setChoice1:nil];
    [self setInput1:nil];
    [self setChoice2:nil];
    [self setInput2:nil];
    [self setChoice3:nil];
    [self setInput3:nil];
    [self setChoice4:nil];
    [self setInput4:nil];
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.lengthUnits count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    label=[[UILabel alloc] initWithFrame:CGRectMake(0,0,50,32)];
    label.backgroundColor=[UIColor clearColor];
    label.text=[self.lengthUnits objectAtIndex:row];
    return label;
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        self.choice1.text=[self.lengthUnits objectAtIndex:row];
    }else if(component==1){
        self.choice2.text=[self.lengthUnits objectAtIndex:row];
    }else if(component==2){
        self.choice3.text=[self.lengthUnits objectAtIndex:row];
    }else{
        self.choice4.text=[self.lengthUnits objectAtIndex:row];
    }
}


- (IBAction)clearInput:(id)sender {
  
    self.input1.text = @"";
    self.input2.text = @"";
    self.input3.text = @"";
    self.input4.text = @"";
}

- (IBAction)bgTaped:(id)sender {
    [self.input1 resignFirstResponder];
    [self.input2 resignFirstResponder];
    [self.input3 resignFirstResponder];
    [self.input4 resignFirstResponder];
}

- (float)toMeter:(NSString *)unit withNumber:(float) number {
    
    if([unit rangeOfString:@"meter"].location!=NSNotFound){
        return number;
    }
    if([unit rangeOfString:@"km" ].location!=NSNotFound){
        return number*1000;
    }
    if([unit rangeOfString:@"cm" ].location!=NSNotFound){
        return number*0.1;
    }
    if([unit rangeOfString:@"feet" ].location!=NSNotFound){
            return number*0.3048;
    }
    if([unit rangeOfString:@"inch" ].location!=NSNotFound){
            return number*0.0254;
        }
    if([unit rangeOfString:@"yard" ].location!=NSNotFound){
            return number*0.9144;
        }    
    return 0.0;
}

- (float)fromMeter:(NSString *)unit withNumber:(float)number{
    if([unit rangeOfString:@"meter"].location!=NSNotFound){
        return number;
    }
    if([unit rangeOfString:@"km" ].location!=NSNotFound){
        return number*0.001;
    }
    if([unit rangeOfString:@"cm" ].location!=NSNotFound){
        return number*10;
    }
    if([unit rangeOfString:@"feet" ].location!=NSNotFound){
        return number*3.2808;
    }
    if([unit rangeOfString:@"inch" ].location!=NSNotFound){
        return number*39.3701;
    }
    if([unit rangeOfString:@"yard" ].location!=NSNotFound){
        return number*1.0936;
    }
    return 0.0;
}

- (IBAction)convent:(id)sender {
    
    if(sender==self.input1){
       float number=self.input1.text.floatValue;
        if(number!=0.0){
        float re2,re3,re4;
        if([self.choice1.text compare:@"meter"]==0){
            re2=[self fromMeter:self.choice2.text withNumber:number];
            re3=[self fromMeter:self.choice3.text withNumber:number];
            re4=[self fromMeter:self.choice4.text withNumber:number];
        }
        else{
            float temp=[self toMeter:self.choice1.text withNumber:number];
            re2=[self fromMeter:self.choice2.text withNumber:temp];
            re3=[self fromMeter:self.choice3.text withNumber:temp];
            re4=[self fromMeter:self.choice4.text withNumber:temp];
        }
        NSString *s2=[NSString stringWithFormat:@"%.4f",re2];
        NSString *s3=[NSString stringWithFormat:@"%.4f",re3];
        NSString *s4=[NSString stringWithFormat:@"%.4f",re4];
        self.input2.text=s2;
        self.input3.text=s3;
        self.input4.text=s4;
        }
    }else if(sender==self.input2){
        float number=self.input2.text.floatValue;
        if(number!=0.0){
        float re1,re3,re4;
        if([self.choice2.text compare:@"meter"]==0){
            re1=[self fromMeter:self.choice1.text withNumber:number];
            re3=[self fromMeter:self.choice3.text withNumber:number];
            re4=[self fromMeter:self.choice4.text withNumber:number];
        }
        else{
            float temp=[self toMeter:self.choice2.text withNumber:number];
            re1=[self fromMeter:self.choice1.text withNumber:temp];
            re3=[self fromMeter:self.choice3.text withNumber:temp];
            re4=[self fromMeter:self.choice4.text withNumber:temp];
        }
        NSString *s1=[NSString stringWithFormat:@"%.4f",re1];
        NSString *s3=[NSString stringWithFormat:@"%.4f",re3];
        NSString *s4=[NSString stringWithFormat:@"%.4f",re4];
        self.input1.text=s1;
        self.input3.text=s3;
        self.input4.text=s4;
        }
    }else if(sender==self.input3){
        float number=self.input3.text.floatValue;
        if(number!=0.0){
        float re1,re2,re4;
        if([self.choice3.text compare:@"meter"]==0){
            re1=[self fromMeter:self.choice1.text withNumber:number];
            re2=[self fromMeter:self.choice2.text withNumber:number];
            re4=[self fromMeter:self.choice4.text withNumber:number];
        }
        else{
            float temp=[self toMeter:self.choice3.text withNumber:number];
            re1=[self fromMeter:self.choice1.text withNumber:temp];
            re2=[self fromMeter:self.choice2.text withNumber:temp];
            re4=[self fromMeter:self.choice4.text withNumber:temp];
        }
        NSString *s1=[NSString stringWithFormat:@"%.4f",re1];
        NSString *s2=[NSString stringWithFormat:@"%.4f",re2];
        NSString *s4=[NSString stringWithFormat:@"%.4f",re4];
        self.input1.text=s1;
        self.input2.text=s2;
        self.input4.text=s4;
        }
    }else{
        float number=self.input4.text.floatValue;
        if(number!=0.0){
        float re1,re2,re3;
        if([self.choice4.text compare:@"meter"]==0){
            re1=[self fromMeter:self.choice1.text withNumber:number];
            re2=[self fromMeter:self.choice2.text withNumber:number];
            re3=[self fromMeter:self.choice3.text withNumber:number];
        }
        else{
            float temp=[self toMeter:self.choice4.text withNumber:number];
            re1=[self fromMeter:self.choice1.text withNumber:temp];
            re2=[self fromMeter:self.choice2.text withNumber:temp];
            re3=[self fromMeter:self.choice3.text withNumber:temp];
        }
        NSString *s1=[NSString stringWithFormat:@"%.4f",re1];
        NSString *s2=[NSString stringWithFormat:@"%.4f",re2];
        NSString *s3=[NSString stringWithFormat:@"%.4f",re3];
        self.input1.text=s1;
        self.input2.text=s2;
        self.input3.text=s3;
        }
    }
    
   
}
@end











