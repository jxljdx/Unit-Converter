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
@synthesize navigationBar;
@synthesize lastInput;

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
    self.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"39.37",@"inch",@"3.2808",@"foot",@"1.0936",@"yard",@"1",@"meter",@"10",@"dm",@"100",@"cm",@"1000",@"mm",@"0.001",@"km",@"0.00062137",@"mile",@"39370",@"mil",@"2834.6",@"point",@"472.44",@"line",@"236.22",@"pica",@"0.19884",@"rod",nil];
    self.classification = @"Length";
    self.choice1.text = @"meter";
    self.choice2.text = @"inch";
    self.choice3.text = @"foot";
    self.choice4.text = @"yard";
    [self.picker selectRow:3 inComponent:0 animated:YES];
    [self.picker selectRow:0 inComponent:1 animated:YES];
    [self.picker selectRow:1 inComponent:2 animated:YES];
    [self.picker selectRow:2 inComponent:3 animated:YES];
    
    self.navigationBar.topItem.title=@"Length";
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if((int)([UIScreen mainScreen].bounds.size.height) == 480){
        NSLog(@"3.5inch");
        self.pickerTrans.transform = CGAffineTransformMakeScale(1.0f, 0.9f);
        CGPoint pos = self.pickerTrans.frame.origin;
        CGPoint newPos = CGPointMake(pos.x, pos.y + 11.5);
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
    [self setNavigationBar:nil];
    [self setInput4:nil];
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
    if(label.text.length>=9){
        label.font=[UIFont systemFontOfSize:10];
    }
    else if(label.text.length>=8){
        label.font=[UIFont systemFontOfSize:12];
    }else if(label.text.length>=7){
        label.font=[UIFont systemFontOfSize:13];
    }
    else if(label.text.length>=6){
        label.font=[UIFont systemFontOfSize:14];
    }
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component==0){
        self.choice1.text=[self.units objectAtIndex:row];
        if(self.lastInput==self.input1){
            [self convert:self.input1];
        }else{
        [self convertByLabel:self.choice1.text withOriginal:self.choice2.text andValue:self.input2.text changeInput:self.input1];
        }
    }else if(component==1){
        self.choice2.text=[self.units objectAtIndex:row];
        if(self.lastInput==self.input2){
            [self convert:self.input2];
        }else{
        [self convertByLabel:self.choice2.text withOriginal:self.choice1.text andValue:self.input1.text changeInput:self.input2];
        }

    }else if(component==2){
        self.choice3.text=[self.units objectAtIndex:row];
        if(self.lastInput==self.input3){
            [self convert:self.input3];
        }else{
        [self convertByLabel:self.choice3.text withOriginal:self.choice1.text andValue:self.input1.text changeInput:self.input3];
        }

    }else{
        self.choice4.text=[self.units objectAtIndex:row];
        if(self.lastInput==self.input4){
            [self convert:self.input4];
        }else{
        [self convertByLabel:self.choice4.text withOriginal:self.choice1.text andValue:self.input1.text changeInput:self.input4];
        }
    }
}



- (double)toUnit:(NSString *)unit withNumber:(double) number {
    
    if([self.classification compare:@"Temperature"]==0){
        if([unit compare:@"°F"]==0){
            return number;
        }else if([unit compare:@"°C"]==0){
            return number*1.8+32;
        }else if([unit compare:@" K"]==0){
            return (number*1.8-459.67);
        }else if([unit compare:@"°Ra"]==0){
            return number-459.67;
        }else if([unit compare:@"°Re"]==0){
            return number*2.25+32;
        }
    }
    
    else{
    if([self.unitMap objectForKey:unit]){
        
        NSString *s=[self.unitMap objectForKey:unit];
        double f=s.doubleValue;
        return number/f;
    }
    }
    return 0.0;
}


- (double)fromUnit:(NSString *)unit withNumber:(double)number{
    if([self.classification compare:@"Temperature"]==0){
        if([unit compare:@"°F"]==0){
            return number;
        }else if([unit compare:@"°C"]==0){
            return (number-32)/1.8;
        }else if([unit compare:@" K"]==0){
            return (number+459.67)/1.8;
        }else if([unit compare:@"°Ra"]==0){
            return number+459.67;
        }else if([unit compare:@"°Re"]==0){
            return (number-32)/2.25;
        }
    }
    else{
    
    if([self.unitMap objectForKey:unit]){
        
        NSString *s=[self.unitMap objectForKey:unit];
        double f=s.doubleValue;
        return number*f;
    }
    
    }
    
    return 0.0;
}

- (void) convertByLabel:(NSString *)label withOriginal:(NSString *) base andValue:(NSString *)value changeInput:(UITextField *) target{
   
    double number=value.doubleValue;
    if(number!=0.0){
        double re;
        double temp=[self toUnit:base withNumber:number];
        re=[self fromUnit:label withNumber:temp];
        NSString *s=[NSString stringWithFormat:@"%f",re];
       
        target.text=s;
    }
}

#pragma mark - convertion handling

- (IBAction)convert:(UITextField *)sender {
    self.lastInput=sender;
  
    if(sender==self.input1){
        double number=self.input1.text.doubleValue;
        if(number!=0.0){
            double re2,re3,re4;
           
            double temp=[self toUnit:self.choice1.text withNumber:number];
            re2=[self fromUnit:self.choice2.text withNumber:temp];
            re3=[self fromUnit:self.choice3.text withNumber:temp];
            re4=[self fromUnit:self.choice4.text withNumber:temp];
            
            NSString *s2=[NSString stringWithFormat:@"%f",re2];
            NSString *s3=[NSString stringWithFormat:@"%f",re3];
            NSString *s4=[NSString stringWithFormat:@"%f",re4];
            self.input2.text=s2;
            self.input3.text=s3;
            self.input4.text=s4;
        }
    }else if(sender==self.input2){
        double number=self.input2.text.doubleValue;
        if(number!=0.0){
            double re1,re3,re4;
            double temp=[self toUnit:self.choice2.text withNumber:number];
            re1=[self fromUnit:self.choice1.text withNumber:temp];
            re3=[self fromUnit:self.choice3.text withNumber:temp];
            re4=[self fromUnit:self.choice4.text withNumber:temp];
            
            NSString *s1=[NSString stringWithFormat:@"%f",re1];
            NSString *s3=[NSString stringWithFormat:@"%f",re3];
            NSString *s4=[NSString stringWithFormat:@"%f",re4];
            self.input1.text=s1;
            self.input3.text=s3;
            self.input4.text=s4;
        }
    }else if(sender==self.input3){
        double number=self.input3.text.doubleValue;
        if(number!=0.0){
            double re1,re2,re4;
            
            double temp=[self toUnit:self.choice3.text withNumber:number];
            re1=[self fromUnit:self.choice1.text withNumber:temp];
            re2=[self fromUnit:self.choice2.text withNumber:temp];
            re4=[self fromUnit:self.choice4.text withNumber:temp];
            
            NSString *s1=[NSString stringWithFormat:@"%f",re1];
            NSString *s2=[NSString stringWithFormat:@"%f",re2];
            NSString *s4=[NSString stringWithFormat:@"%f",re4];
            self.input1.text=s1;
            self.input2.text=s2;
            self.input4.text=s4;
        }
    }else{
        double number=self.input4.text.doubleValue;
        if(number!=0.0){
            double re1,re2,re3;
       
            double temp=[self toUnit:self.choice4.text withNumber:number];
            re1=[self fromUnit:self.choice1.text withNumber:temp];
            re2=[self fromUnit:self.choice2.text withNumber:temp];
            re3=[self fromUnit:self.choice3.text withNumber:temp];
            
            NSString *s1=[NSString stringWithFormat:@"%f",re1];
            NSString *s2=[NSString stringWithFormat:@"%f",re2];
            NSString *s3=[NSString stringWithFormat:@"%f",re3];
            self.input1.text=s1;
            self.input2.text=s2;
            self.input3.text=s3;
        }
    }
    
   
}

- (void)loadDataFromXML {
    
    
    NSURL *url= [[NSURL alloc] initWithString:@"http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml"];
    
    //NSString *URLString = [NSString stringWithContentsOfURL:url];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    //if(URLString==nil){
    if(parser == nil){
        // Connection failed
        
        for(int i=0;i<[self.units count];i++){
            NSString *s=[self.units objectAtIndex:i];
            [self.unitMap setValue:[self.userDefaults objectForKey:s] forKey:s];
        }
    }
    else{
        
        [parser setDelegate:self];
        [parser parse];
    }
    
    [self.unitMap setValue:@"1" forKey:@"EUR"];
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
        //NSLog(@"currency: %@, rate: %@", cur, rate);
        if(cur){
            [self.unitMap setValue:rate forKey:cur];
            [self.userDefaults setValue:rate forKey:cur];
            [self.userDefaults synchronize];
        }
    }
    
}

@end










