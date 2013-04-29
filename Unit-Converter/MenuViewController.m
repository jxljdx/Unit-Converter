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
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:3 inComponent:0 animated:YES];
            [top.picker selectRow:0 inComponent:1 animated:YES];
            [top.picker selectRow:1 inComponent:2 animated:YES];
            [top.picker selectRow:2 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    } else if ([identifier compare:@"Currency"] == 0) {
        
        top.userDefaults = [NSUserDefaults standardUserDefaults];
        top.units=[[NSArray alloc]initWithObjects:@"EUR",@"USD",@"GBP",@"INR",@"AUD",@"CAD",@"CHF",@"CNY",@"JPY",@"MYR",@"HKD",@"ZAR",@"BRL", nil];
        top.unitMap=[[NSMutableDictionary alloc]init];
        top.classification = identifier;
        top.navigationBar.topItem.title = @"Currency";
        top.choice1.text = @"EUR";
        top.choice2.text = @"USD";
        top.choice3.text = @"GBP";
        top.choice4.text = @"CNY";
        top.input1.text=@"";
        top.input2.text=@"";
        top.input3.text=@"";
        top.input4.text=@"";
        [top.picker selectRow:0 inComponent:0 animated:YES];
        [top.picker selectRow:1 inComponent:1 animated:YES];
        [top.picker selectRow:2 inComponent:2 animated:YES];
        [top.picker selectRow:8 inComponent:3 animated:YES];
        
        
        [top.picker reloadAllComponents];
        [self.slidingViewController resetTopView];
        if(top.userDefaults == nil){
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"EUR",@"1.3113",@"USD",@"0.84400",@"GBP",@"71.0370",@"INR",@"1.2671",@"AUD",@"1.3293",@"CAD",@"1.2279",@"CHF",@"8.0842",@"CNY",@"128.27",@"JPY",@"3.9766",@"MYR",@"10.1777",@"HKD",@"11.7470",@"ZAR",@"2.6112",@"BRL",@"7.4564",@"DKK", nil];
            NSString *time=@"2013-4-29";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Last Update"
                                                            message:time
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            [top loadDataFromXML];
        }
        
    } else if ([identifier compare:@"Temperature"] == 0) {
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        top.units = [[NSArray alloc]initWithObjects: @"°C",@"°F",@" K",@"°Ra",@"°Re",nil];
        
//        top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"°C",@"2",@"°F",@"3",@" K",@"4",@"°Ra",@"5",@"°Re",nil];
        top.classification = identifier;
        top.navigationBar.topItem.title = @"Temperature";
        top.choice1.text = @"°F";
        top.choice2.text = @"°C";
        top.choice3.text = @" K";
        top.choice4.text = @"°Ra";
        top.input1.text=@"";
        top.input2.text=@"";
        top.input3.text=@"";
        top.input4.text=@"";
        [top.picker selectRow:1 inComponent:0 animated:YES];
        [top.picker selectRow:0 inComponent:1 animated:YES];
        [top.picker selectRow:2 inComponent:2 animated:YES];
        [top.picker selectRow:3 inComponent:3 animated:YES];
        
        [top.picker reloadAllComponents];
        [self.slidingViewController resetTopView];
    }];
    }else if ([identifier compare:@"Weight"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"kg",@"lb(US)",@"lb(Metric)",@"oz(US)",@"stone",@"ton(US)",@"ton(UK)",@"ton",@"g",@"mg",@"gr",@"kt",@"ct",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"kg",@"2.204623",@"lb(US)",@"2",@"lb(Metric)",@"35.273962",@"oz(US)",@"0.157473",@"stone",@"0.001102",@"ton(US)",@"0.000984",@"ton(UK)",@"0.001",@"ton",@"1000",@"g",@"1000000",@"mg",@"15432.358353",@"gr",@"4873.294347",@"kt",@"5000",@"ct",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Weight";
            top.choice1.text = @"kg";
            top.choice2.text = @"lb(US)";
            top.choice3.text = @"oz(US)";
            top.choice4.text = @"g";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:3 inComponent:2 animated:YES];
            [top.picker selectRow:8 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Area"] == 0) {
        NSLog(@"area");
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"acre(int)",@"ha",@"mile²",@"yard²",@"foot²",@"inch²",@"km²",@"m²",@"dm²",@"cm²",@"mm²",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"acre(int)",@"0.404686",@"ha",@"0.001563",@"mile²",@"4840",@"yard²",@"43560",@"foot²",@"6273041.474654",@"inch²",@"0.004047",@"km²",@"4046.856422",@"m²",@"404685.642229",@"dm²",@"40468564.222909",@"cm²",@"4046856422.290866",@"mm²",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Area";
            top.choice1.text = @"acre(int)";
            top.choice2.text = @"ha";
            top.choice3.text = @"mile²";
            top.choice4.text = @"m²";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:7 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Angle"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"°",@"\'",@"\"",@"radian",@"mil",@"grad",@"point",@"circle",@"1/2 circle",@"1/4 circle",@"1/8 circle",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"°",@"60",@"\'",@"3600",@"\"",@"0.017453",@"radian",@"17.777778",@"mil",@"1.111111",@"grad",@"0.088889",@"point",@"0.002778",@"circle",@"0.005556",@"1/2 circle",@"0.011111",@"1/4 circle",@"0.022222",@"1/8 circle",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Angle";
            top.choice1.text = @"°";
            top.choice2.text = @"\'";
            top.choice3.text = @"\"";
            top.choice4.text = @"mil";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:4 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Density"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"gr/gal(US)",@"gr/gal(UK)",@"gram/l",@"g/cm³",@"kg/m³",@"oz./in³",@"oz./gal(UK)",@"oz./gal(US)",@"lb./in³",@"lb./ft³",@"lb./gal(UK)",@"lb./gal(US)",@"slug/ft³",@"T/m³",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"gr/gal(US)",@"1.200931",@"gr/gal(UK)",@"0.017118",@"gram/l",@"0.000017118",@"g/cm³",@"0.017118",@"kg/m³",@"0.000009895",@"oz./in³",@"0.002745",@"oz./gal(UK)",@"0.002286",@"oz./gal(US)",@"0.000000618",@"lb./in³",@"0.001069",@"lb./ft³",@"0.000172",@"lb./gal(UK)",@"0.000143",@"lb./gal(US)",@"0.000033215",@"slug/ft³",@"0.000017",@"T/m³",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Density";
            top.choice1.text = @"g/cm³";
            top.choice2.text = @"kg/m³";
            top.choice3.text = @"gr/gal(US)";
            top.choice4.text = @"gr/gal(UK)";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:3 inComponent:0 animated:YES];
            [top.picker selectRow:4 inComponent:1 animated:YES];
            [top.picker selectRow:0 inComponent:2 animated:YES];
            [top.picker selectRow:1 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Energy"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"J",@"kJ",@"dJ",@"cJ",@"cal",@"kcal",@"Btu",@"eV",@"erg",@"hp h",@"Wh",@"kWh",@"therm(US)",@"therm(Eur)",@"gal.(US)gas",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"J",@"0.001",@"kJ",@"10",@"dJ",@"100",@"cJ",@"0.238846",@"cal",@"0.000238846",@"kcal",@"0.000948",@"Btu",@"6241506479963234304",@"eV",@"10000000",@"erg",@"0.0000004",@"hp h",@"0.000278",@"Wh",@"0.000000278",@"kWh",@"0.00948",@"therm(US)",@"0.009478",@"therm(Eur)",@"0.00759",@"gal.(US)gas",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Energy";
            top.choice1.text = @"J";
            top.choice2.text = @"kJ";
            top.choice3.text = @"dJ";
            top.choice4.text = @"cJ";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:3 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Force"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"N",@"dyn",@"mGf",@"pdl",@"tnf",@"kip",@"sthene",@"kgf",@"lbf",@"ozf",@"kN",@"mN",@"dN",@"cN",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"N",@"100000",@"dyn",@"101.971101",@"mGf",@"7.233014",@"pdl",@"0.000112",@"tnf",@"0.000225",@"kip",@"0.001",@"sthene",@"0.101972",@"kgf",@"0.224809",@"lbf",@"3.596943",@"ozf",@"0.001",@"kN",@"0.000001",@"mN",@"10",@"dN",@"100",@"cN",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Force";
            top.choice1.text = @"N";
            top.choice2.text = @"mGf";
            top.choice3.text = @"pdl";
            top.choice4.text = @"kN";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:2 inComponent:1 animated:YES];
            [top.picker selectRow:3 inComponent:2 animated:YES];
            [top.picker selectRow:10 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Volume"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"m³",@"mm³",@"liter",@"hl",@"dl",@"ml",@"µl",@"ft³",@"in³",@"gal(US)",@"qt(US)",@"pt(US)",@"gill(US)",@"gal(UK)",@"qt(UK)",@"pt(UK)",@"gill(UK)",@"ounce(US)",@"ounce(UK)",@"cup(US)",@"cup(Metric)",@"cup(CA)",@"tbsp(US)",@"tbsp(Metric)",@"tbsp(UK)",@"tsp(US)",@"tsp(Metric)",@"tsp(UK)",@"Dram",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"m³",@"1000000000",@"mm³",@"999.999986",@"liter",@"10",@"hl",@"9999.999855",@"dl",@"999999.98553",@"ml",@"999999985.530091",@"µl",@"35.314666",@"ft³",@"61024.133765",@"in³",@"264.17206",@"gal(US)",@"1056.688194",@"qt(US)",@"2113.376388",@"pt(US)",@"8453.505553",@"gill(US)",@"219.969245",@"gal(UK)",@"879.87698",@"qt(UK)",@"1759.753961",@"pt(UK)",@"7039.015844",@"gill(UK)",@"33814.022211",@"ounce(US)",@"35195.079219",@"ounce(UK)",@"4226.752777",@"cup(US)",@"3999.999942",@"cup(Metric)",@"4399.384902",@"cup(CA)",@"67628.044425",@"tbsp(US)",@"66666.665701",@"tbsp(Metric)",@"70390.158436",@"tbsp(UK)",@"202884.133272",@"tsp(US)",@"199999.9971",@"tsp(Metric)",@"281560.633746",@"tsp(UK)",@"270512.177706",@"Dram",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Volume";
            top.choice1.text = @"m³";
            top.choice2.text = @"liter";
            top.choice3.text = @"ft³";
            top.choice4.text = @"in³";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:2 inComponent:1 animated:YES];
            [top.picker selectRow:7 inComponent:2 animated:YES];
            [top.picker selectRow:8 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Pressure"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"pa",@"atm",@"bar",@"mBar",@"microBar",@"psi",@"ksf",@"ksi",@"lb/ft²",@"lb/in²",@"N/m²",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"pa",@"0.00001",@"atm",@"0.00001",@"bar",@"0.01",@"mBar",@"10",@"microBar",@"0.000145",@"psi",@"0.000021",@"ksf",@"0.0000001",@"ksi",@"0.020885",@"lb/ft²",@"0.000145",@"lb/in²",@"1",@"N/m²",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Pressure";
            top.choice1.text = @"pa";
            top.choice2.text = @"bar";
            top.choice3.text = @"psi";
            top.choice4.text = @"ksf";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:2 inComponent:1 animated:YES];
            [top.picker selectRow:5 inComponent:2 animated:YES];
            [top.picker selectRow:6 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Power"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"W",@"kW",@"Btu/h",@"Btu/m",@"Btu/s",@"calorie/h",@"calorie/m",@"calorie/s",@"ft lb/h",@"ft lb/m",@"ft lb/s",@"hp(int.)",@"hp(metr.)",@"bhp",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"W",@"0.001",@"kW",@"3.412142",@"Btu/h",@"0.056869",@"Btu/m",@"0.000948",@"Btu/s",@"859.845228",@"calorie/h",@"14.330754",@"calorie/m",@"0.238846",@"calorie/s",@"2655.223834",@"ft lb/h",@"44.253731",@"ft lb/m",@"0.737562",@"ft lb/s",@"0.001341",@"hp(int.)",@"0.00136",@"hp(metr.)",@"0.000102",@"bhp",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Power";
            top.choice1.text = @"W";
            top.choice2.text = @"kW";
            top.choice3.text = @"Btu/h";
            top.choice4.text = @"calorie/h";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:0 inComponent:0 animated:YES];
            [top.picker selectRow:1 inComponent:1 animated:YES];
            [top.picker selectRow:2 inComponent:2 animated:YES];
            [top.picker selectRow:5 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Time"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"year",@"week",@"day",@"hour",@"min",@"sec",@"ms",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0.000002",@"year",@"0.000099",@"week",@"0.000694",@"day",@"0.016667",@"hour",@"1",@"min",@"60",@"sec",@"60000",@"ms",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Time";
            top.choice1.text = @"min";
            top.choice2.text = @"sec";
            top.choice3.text = @"hour";
            top.choice4.text = @"day";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:4 inComponent:0 animated:YES];
            [top.picker selectRow:5 inComponent:1 animated:YES];
            [top.picker selectRow:3 inComponent:2 animated:YES];
            [top.picker selectRow:2 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }else if ([identifier compare:@"Data Storage"] == 0) {
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            top.units = [[NSArray alloc]initWithObjects: @"bit",@"nibble",@"byte",@"character",@"word",@"block",@"kilobit",@"kilobyte",@"megabit",@"megabyte",@"gigabit",@"gigabyte",@"terabit",@"terabyte",nil];
            
            top.unitMap = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"8192",@"bit",@"2048",@"nibble",@"1024",@"byte",@"1024",@"character",@"512",@"word",@"2",@"block",@"8",@"kilobit",@"1",@"kilobyte",@"0.0078125",@"megabit",@"0.000976562",@"megabyte",@"0.0000076293945",@"gigabit",@"0.00000095367431640625",@"gigabyte",@"0.0000000074505806",@"terabit",@"0.000000000931322574615",@"terabyte",nil];
            top.classification = identifier;
            top.navigationBar.topItem.title = @"Data Storage";
            top.choice1.text = @"byte";
            top.choice2.text = @"kilobyte";
            top.choice3.text = @"bit";
            top.choice4.text = @"word";
            top.input1.text=@"";
            top.input2.text=@"";
            top.input3.text=@"";
            top.input4.text=@"";
            [top.picker selectRow:2 inComponent:0 animated:YES];
            [top.picker selectRow:7 inComponent:1 animated:YES];
            [top.picker selectRow:0 inComponent:2 animated:YES];
            [top.picker selectRow:4 inComponent:3 animated:YES];
            
            [top.picker reloadAllComponents];
            [self.slidingViewController resetTopView];
        }];
    }


}

@end











