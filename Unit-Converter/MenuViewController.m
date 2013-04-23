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
    self.menuItems = [NSArray arrayWithObjects:@"Currency", @"Length", @"Area", @"Degree", @"Volume", @"Mass",
                      @"Temperature", @"Velocity", @"Pressure", @"Power", @"Energy", @"Force", @"Time", @"Iuminance",
                      @"Density", @"Data storage", nil];
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
            top.unitMap = [[NSDictionary alloc] initWithObjectsAndKeys:@"39.37",@"inch",@"3.2808",@"foot",@"1.0936",@"yard",@"1",@"meter",@"10",@"dm",@"100",@"cm",@"1000",@"mm",@"0.001",@"km",@"0.00062137",@"mile",@"39370",@"mil",@"2834.6",@"point",@"472.44",@"line",@"236.22",@"pica",@"0.19884",@"rod",nil];
            top.classification = identifier;
            top.choice1.text = @"meter";
            top.choice2.text = @"inch";
            top.choice3.text = @"feet";
            top.choice4.text = @"yard";
            [top.picker selectRow:3 inComponent:0 animated:YES];
            [top.picker selectRow:0 inComponent:1 animated:YES];
            [top.picker selectRow:1 inComponent:2 animated:YES];
            [top.picker selectRow:2 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    } else if ([identifier compare:@"Currency"] == 0) {
        
    } else if ([identifier compare:@"Area"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"a",@"b",@"c",@"d",nil];
            top.unitMap = [[NSDictionary alloc] initWithObjectsAndKeys:@"1.1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",nil];
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
    } // TODO
}

@end











