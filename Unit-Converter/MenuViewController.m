//
//  MenuViewController.m
//  Unit-Converter
//
//  Created by Jundong Liao on 4/18/13.
//  Copyright (c) 2013 Jundong Liao. All rights reserved.
//

#import "MenuViewController.h"
#import "TopViewController.h"
#import "CurrencyViewController.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController
@synthesize menuItems = _menuItems;
@synthesize images;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    self.menuItems = [NSArray arrayWithObjects:@"Currency", @"Length",@"Temperature", @"Weight",@"Area", @"Angle", @"Density",@"Energy", @"Force", @"Volume", @"Pressure", @"Power", @"Time",  @"Data Storage", nil];
    self.images=[[NSArray alloc] initWithObjects:@"currency.jpg", @"ruler.png",@"temperature.png",@"weight.png",@"area.png",@"angle.png",@"density.png",@"energy.png",@"force.png",@"volume.png",@"pressure.png",@"power.png",@"time.png",@"data.png",nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.menuItems.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.menuItems objectAtIndex:indexPath.row];
    
    /*UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];*/
    
    /*if ([self.slidingViewController.topViewController isMemberOfClass:[CurrencyViewController class]]) {
        // if current selection is Currency
        if ([identifier compare:@"Currency"] == 0) {
            [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
                [self.slidingViewController resetTopView];
            }];
        } else {
            UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Top"];
            [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
                CGRect frame = self.slidingViewController.topViewController.view.frame;
                self.slidingViewController.topViewController = newTopViewController;
                self.slidingViewController.topViewController.view.frame = frame;
                [self.slidingViewController resetTopView];
            }];
        }
        
    }*/
    
    TopViewController* top = nil;
    if ([self.slidingViewController.topViewController isMemberOfClass:[TopViewController class]]) {
        top = (TopViewController*)self.slidingViewController.topViewController;
    }
    if (top == nil) return;
    if ([top.classification compare:identifier] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            [self.slidingViewController resetTopView];
        }];
        return;
    }
    
    // Set units and units-map based on chosen classification, such as Length
 
    
    if ([identifier compare:@"Length"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"inch",@"foot",@"yard",@"meter",@"dm",@"cm",@"mm",@"km",@"mile",@"mil",@"point",@"line",@"pica",@"rod",nil];
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"39.37",@"inch",@"3.2808",@"foot",@"1.0936",@"yard",@"1",@"meter",@"10",@"dm",@"100",@"cm",@"1000",@"mm",@"0.001",@"km",@"0.00062137",@"mile",@"39370",@"mil",@"2834.6",@"point",@"472.44",@"line",@"236.22",@"pica",@"0.19884",@"rod",nil];
            top.classification = identifier;
           top.navigationBar.topItem.title = @"Length";
            top.choice1.text = @"meter";
            top.choice2.text = @"inch";
            top.choice3.text = @"foot";
            top.choice4.text = @"yard";
            [top.picker selectRow:3 inComponent:0 animated:YES];
            [top.picker selectRow:0 inComponent:1 animated:YES];
            [top.picker selectRow:1 inComponent:2 animated:YES];
            [top.picker selectRow:2 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    } else if ([identifier compare:@"Currency"] == 0) {
        
        top.userDefaults = [NSUserDefaults standardUserDefaults];
        top.units=[[NSArray alloc]initWithObjects:@"EUR",@"USD",@"GBP",@"INR",@"AUD",@"CAD",@"AED",@"CHF",@"CNY",@"JPY",@"MYR",@"HKD", nil];
        top.unitMap=[[NSMutableDictionary alloc]init];
        top.classification = identifier;
        top.navigationBar.topItem.title = @"Currency";
        top.choice1.text = @"EUR";
        top.choice2.text = @"USD";
        top.choice3.text = @"GBP";
        top.choice4.text = @"CNY";
        [top.picker selectRow:0 inComponent:0 animated:YES];
        [top.picker selectRow:1 inComponent:1 animated:YES];
        [top.picker selectRow:2 inComponent:2 animated:YES];
        [top.picker selectRow:8 inComponent:3 animated:YES];
        [top loadDataFromXML];
        
        [top.picker reloadAllComponents];
        [self.slidingViewController resetTopView];
        
    } else if ([identifier compare:@"Area"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    } else if ([identifier compare:@"Temperature"] == 0) {
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        top.units = [[NSArray alloc]initWithObjects: @"C",@"F",@"K",@"Re",@"Ra",nil];
        
        top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"C",@"2",@"b",@"3",@"c",@"4",@"d",nil];
        top.classification = identifier;
        top.choice1.text = @"a";
        top.choice2.text = @"b";
        top.choice3.text = @"c";
        top.choice4.text = @"d";
        [top.picker selectRow:0 inComponent:0 animated:YES];
        [top.picker selectRow:1 inComponent:1 animated:YES];
        [top.picker selectRow:2 inComponent:2 animated:YES];
        [top.picker selectRow:3 inComponent:3 animated:YES];
        
        [top.picker reloadAllComponents];
        [self.slidingViewController resetTopView];
    }];
    }else if ([identifier compare:@"Weight"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Area"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Angle"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Density"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Energy"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Force"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Volume"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Pressure"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"pa",@"atm",@"bar",@"mBar",@"microBar",@"psi",@"ksf",@"ksi",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"pa",@"0.00001",@"atm",@"0.00001",@"bar",@"0.01",@"mBar",@"10",@"microBar",@"0.000145",@"psi",@"0.000021",@"ksf",@"0.0000001",@"ksi",nil];
            top.classification = identifier;
            top.choice1.text = @"pa";
            top.choice2.text = @"bar";
            top.choice3.text = @"psi";
            top.choice4.text = @"ksf";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:2 inComponent:1 animated:YES];
            [top.picker selectRow:5 inComponent:2 animated:YES];
            [top.picker selectRow:6 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Power"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Time"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"year",@"week",@"day",@"hour",@"min",@"sec",@"ms",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0.000002",@"year",@"0.000099",@"week",@"0.000694",@"day",@"0.016667",@"hour",@"1",@"min",@"60",@"sec",@"60000",@"ms",nil];
            top.classification = identifier;
            top.choice1.text = @"min";
            top.choice2.text = @"sec";
            top.choice3.text = @"hour";
            top.choice4.text = @"day";
            [top.picker selectRow:4 inComponent:0 animated:YES];
            [top.picker selectRow:5 inComponent:1 animated:YES];
            [top.picker selectRow:3 inComponent:2 animated:YES];
            [top.picker selectRow:2 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Data Storage"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
            top.classification = identifier;
            top.choice1.text = @"a";
            top.choice2.text = @"b";
            top.choice3.text = @"c";
            top.choice4.text = @"d";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }


}

@end











