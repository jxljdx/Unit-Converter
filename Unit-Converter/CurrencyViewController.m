//
//  CurrencyViewController.m
//  Unit-Converter
//
//  Created by Jundong Liao on 4/18/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import "CurrencyViewController.h"

@interface CurrencyViewController ()

@end

@implementation CurrencyViewController
@synthesize choice1;
@synthesize choice2;
@synthesize choice3;
@synthesize choice4;
@synthesize input1;
@synthesize input2;
@synthesize input3;
@synthesize input4;
@synthesize pickerTrans;
@synthesize picker;
@synthesize curUnits;
@synthesize currency;
@synthesize userDefaults;

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
	// Do any additional setup after loading the view.
    
    self.currency=[[NSMutableDictionary alloc] init];
    self.curUnits=[[NSMutableArray alloc] init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.curUnits=[[NSArray alloc]initWithObjects:@"EUR",@"USD",@"GBP",@"INR",@"AUD",@"CAD",@"AED",@"CHF",@"CNY",@"JPY",@"MYR",@"HKD", nil];
    
    [self loadDataFromXML];
    
    [self.picker selectRow:0 inComponent:0 animated:YES];
    [self.picker selectRow:1 inComponent:1 animated:YES];
    [self.picker selectRow:2 inComponent:2 animated:YES];
    [self.picker selectRow:8 inComponent:3 animated:YES];
    
   
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    if((int)([UIScreen mainScreen].bounds.size.height) == 480){
        self.pickerTrans.transform = CGAffineTransformMakeScale(1.0f, 0.9f);
        CGPoint pos = self.pickerTrans.frame.origin;
        CGPoint newPos = CGPointMake(pos.x, pos.y + 12.5);
        self.pickerTrans.frame = CGRectMake(newPos.x, newPos.y, self.pickerTrans.frame.size.width, self.pickerTrans.frame.size.height);
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}


- (void)loadDataFromXML {
    
    
    NSURL *url= [[NSURL alloc] initWithString:@"http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml"];
    
    NSString *URLString = [NSString stringWithContentsOfURL:url];
    if(URLString==nil){
        // Connection failed
        
        for(int i=0;i<[self.curUnits count];i++){
           NSString *s=[self.curUnits objectAtIndex:i];
            [self.currency setValue:[self.userDefaults objectForKey:s] forKey:s];
        }
    }
    else{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    }
    NSString *time=[self.userDefaults objectForKey:@"time"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Last Update"
                                                    message:time
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"Cube"]) {
        NSString* time= [attributeDict valueForKey:@"time"];   //get update time
        if(time){
            [self.userDefaults setValue:time forKey:@"time"];
            [self.userDefaults synchronize];

        }
        
        NSString* cur = [attributeDict valueForKey:@"currency"];  //get curency rate
        NSString* rate = [attributeDict valueForKey:@"rate"];
       // NSLog(@"currency: %@, rate: %@", cur, rate);
        if(cur){
            [self.currency setValue:rate forKey:cur];
            [self.userDefaults setValue:rate forKey:cur];
            [self.userDefaults synchronize];
        }
    }
   
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.curUnits count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    label=[[UILabel alloc] initWithFrame:CGRectMake(0,0,50,32)];
    label.backgroundColor=[UIColor clearColor];
    label.text=[self.curUnits objectAtIndex:row];
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        self.choice1.text=[self.curUnits objectAtIndex:row];
    }else if(component==1){
        self.choice2.text=[self.curUnits objectAtIndex:row];
    }else if(component==2){
        self.choice3.text=[self.curUnits objectAtIndex:row];
    }else{
        self.choice4.text=[self.curUnits objectAtIndex:row];
    }
}

- (void)viewDidUnload {
    [self setChoice1:nil];
    [self setInput1:nil];
    [self setChoice2:nil];
    [self setInput2:nil];
    [self setChoice3:nil];
    [self setInput3:nil];
    [self setChoice4:nil];
    [self setInput4:nil];
    [self setPickerTrans:nil];
    [self setPicker:nil];
    [super viewDidUnload];
}
- (IBAction)clearInput:(id)sender {
    
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


- (float)fromEUR:(NSString *)unit withNumber:(float) number {
    
    float cur;
    
    if([unit rangeOfString:@"EUR"].location!=NSNotFound){
        return number;
    }
//    if([unit rangeOfString:@"USD" ].location!=NSNotFound){
//        NSString *currency=@"USD";
//        NSString *rate=[self.currency objectForKey:currency];
//        cur=rate.floatValue;
//        return number*cur;
//    }

    else if([self.currency objectForKey:unit]!=nil){
        NSString *rate=[self.currency objectForKey:unit];
        cur=rate.floatValue;
        return number*cur;
    }

    return 0.0;
}

- (float)toEUR:(NSString *)unit withNumber:(float)number{
    float cur;
    
    if([unit rangeOfString:@"EUR"].location!=NSNotFound){
        return number;
    }
    
    else if([self.currency objectForKey:unit]!=nil){
        NSString *rate=[self.currency objectForKey:unit];
        cur=rate.floatValue;
        return number/cur;
    }
    
    return 0.0;
}


- (IBAction)convert:(id)sender {
    
    if(sender==self.input1){
        float number=self.input1.text.floatValue;
        if(number!=0.0){
            float re2,re3,re4;
            if([self.choice1.text compare:@"EUR"]==0){
                re2=[self fromEUR:self.choice2.text withNumber:number];
                re3=[self fromEUR:self.choice3.text withNumber:number];
                re4=[self fromEUR:self.choice4.text withNumber:number];
            }
            else{
                float temp=[self toEUR:self.choice1.text withNumber:number];
                re2=[self fromEUR:self.choice2.text withNumber:temp];
                re3=[self fromEUR:self.choice3.text withNumber:temp];
                re4=[self fromEUR:self.choice4.text withNumber:temp];
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
            if([self.choice2.text compare:@"EUR"]==0){
                re1=[self fromEUR:self.choice1.text withNumber:number];
                re3=[self fromEUR:self.choice3.text withNumber:number];
                re4=[self fromEUR:self.choice4.text withNumber:number];
            }
            else{
                float temp=[self toEUR:self.choice2.text withNumber:number];
                re1=[self fromEUR:self.choice1.text withNumber:temp];
                re3=[self fromEUR:self.choice3.text withNumber:temp];
                re4=[self fromEUR:self.choice4.text withNumber:temp];
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
            if([self.choice3.text compare:@"EUR"]==0){
                re1=[self fromEUR:self.choice1.text withNumber:number];
                re2=[self fromEUR:self.choice2.text withNumber:number];
                re4=[self fromEUR:self.choice4.text withNumber:number];
            }
            else{
                float temp=[self toEUR:self.choice3.text withNumber:number];
                re1=[self fromEUR:self.choice1.text withNumber:temp];
                re2=[self fromEUR:self.choice2.text withNumber:temp];
                re4=[self fromEUR:self.choice4.text withNumber:temp];
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
            if([self.choice4.text compare:@"EUR"]==0){
                re1=[self fromEUR:self.choice1.text withNumber:number];
                re2=[self fromEUR:self.choice2.text withNumber:number];
                re3=[self fromEUR:self.choice3.text withNumber:number];
            }
            else{
                float temp=[self toEUR:self.choice4.text withNumber:number];
                re1=[self fromEUR:self.choice1.text withNumber:temp];
                re2=[self fromEUR:self.choice2.text withNumber:temp];
                re3=[self fromEUR:self.choice3.text withNumber:temp];
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
