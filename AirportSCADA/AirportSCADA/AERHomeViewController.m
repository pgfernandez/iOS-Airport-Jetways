//
//  AERHomeViewController.m
//  AirportSCADA
//
//  Created by Pedro Garcia Fernandez on 16/08/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERHomeViewController.h"



@interface AERHomeViewController (){

    // Define keys
    NSString *jetwayName;
    NSString *jetwayStatus;
    NSString *jetway400HzStatus;
    NSString *jetwayACStatus;
    NSString *jetwayDGSStatus;
    
    
    NSMutableArray *flightsArray;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *flightCode;
    NSString *company;
    NSString *destination;
    NSString *std;
    
    //para la tabla de vuelos
    NSMutableString *flight_tmp;
    NSDictionary *tmpDict;
    NSMutableString *std_tmp;
    NSMutableString *destination_tmp;
    NSString *airlineCode;
   
    
}
@end

@interface AERHomeViewController ()

@end

@implementation AERHomeViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _model = [[AERMenu alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    NSLog(@"entro en numero de secciones %i", 1);
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"entro en numero de filas %i", 1);
    
    if (tableView == self.systemsTable){
        return self.model.menuItemsCount;
    }else{
        return flightsArray.count;
        //número de vuelos
    }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"En CREANDO CELDAS");
    
    // Averiguo qué opción es
    NSString *item;
    
    
    
    if (tableView == self.systemsTable) {
        item = [self.model menuItemAtIndex:indexPath.row];
    } else {
       
        tmpDict = [flightsArray objectAtIndex:indexPath.row];
        
        
        flight_tmp = [NSMutableString stringWithFormat:@"%@",
                      [tmpDict objectForKeyedSubscript:flightCode]];
        
        
        std_tmp = [NSMutableString stringWithFormat:@"%@",
                   [tmpDict objectForKeyedSubscript:std]];
        
        
        destination_tmp = [NSMutableString stringWithFormat:@"%@",
                           [tmpDict objectForKeyedSubscript:destination]];
        
        
        
    }
    
    
    
    // Creo una celda
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    
    if (cell == nil) {
        
        
        
        if (tableView == self.systemsTable) {
            item = [self.model menuItemAtIndex:indexPath.row];
        
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
        
                cell.textLabel.textColor = [UIColor blackColor];
        } else { //tabla de vuelos
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellId];
            
            if (indexPath.row % 2) {
                cell.backgroundColor = [UIColor whiteColor];
            }else {
                cell.backgroundColor = [UIColor colorWithRed:0.788 green:0.863 blue:0.91 alpha:1];
    
            }

            
            
        }
        
        
    }
    
    if (tableView == self.systemsTable) {
            cell.textLabel.text = [item description];
    } else {
        NSMutableString *flightData = [[NSMutableString alloc]init];
        [flightData appendString:flight_tmp];
        [flightData appendString:@" "];
        [flightData appendString:std_tmp];
        
        NSMutableString *flightDetailData = [[NSMutableString alloc]init];
        [flightDetailData appendString:destination_tmp];
        [flightDetailData appendString:@" "];
        
        //cell.textLabel.text = flight.flightNumber;
        //cell.detailTextLabel.text = flight.destination;
        
        cell.textLabel.text = flightData;
        cell.detailTextLabel.text = flightDetailData;


    }
    
    return cell;
    
}



#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *item = nil;
    
    if (tableView == self.systemsTable) {
        item =[self.model menuItemAtIndex:indexPath.row];
    } else {
        //vuelos no los voy a seleccionar
    }
 
    
    
    if ([self.delegate conformsToProtocol:@protocol(AERHomeViewControllerDelegate)]) {
        [self.delegate didSelectMenuItem:item];
    }
    
    
    
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




#pragma mark - jetway action
-(IBAction)showJetwayInfo:(id)sender{

    NSLog(@"Jetway selected: %@", [sender currentTitle]);
    
    NSString *url = [[NSString alloc]initWithFormat:@"http://192.168.1.35:8188/scada/jetways/%@", [sender currentTitle]];
   
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:
                                                     jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    NSString *jetway_data = [jsonObjects objectForKey:@"jetway"];
    NSString *hz_data = [jsonObjects objectForKey:@"400Hz"];
    NSString *ac_data = [jsonObjects objectForKey:@"AC"];
    NSString *dgs_data = [jsonObjects objectForKey:@"DGS"];
    NSString *status_data = [jsonObjects objectForKey:@"status"];
    
    if ([status_data  isEqual: @"1"]) {
        status_data = @"On";
        self.jetwayStatus.backgroundColor = [UIColor greenColor];
    }else{
        status_data = @"Off";
        self.jetwayStatus.backgroundColor = [UIColor redColor];
    }
    
    if ([hz_data  isEqual: @"1"]) {
        hz_data = @"On";
    }else{
        hz_data = @"Off";
    }
    
    if ([ac_data  isEqual: @"1"]) {
        ac_data = @"On";
    }else{
        ac_data = @"Off";
    }
    
    if ([dgs_data  isEqual: @"1"]) {
        dgs_data = @"On";
    }else{
        dgs_data = @"Off";
    }
        
        NSLog(@"Jetway Data: %@",jetway_data);
        NSLog(@"Status: %@",status_data);
        NSLog(@"400Hz: %@",hz_data);
        NSLog(@"AC: %@",ac_data);
        NSLog(@"DGS: %@",dgs_data);
    
   //consulto los vuelos
    
    flightCode = @"Flight";
    company = @"ICAO";
    destination = @"Destination";
    std = @"STD";
    
    flightsArray = [[NSMutableArray alloc]init];
    
    url = [[NSString alloc]initWithFormat:@"http://192.168.1.35:8181/departures/%@", [sender currentTitle]];
    
    jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    
    jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *flight_data = [dataDict objectForKey:@"Flight"];
        NSString *company_data = [dataDict objectForKey:@"ICAO"];
        NSString *destination_data = [dataDict objectForKey:@"Destination"];
        NSString *std_data = [dataDict objectForKey:@"STD"];
        
        NSLog(@"Flight Data: %@",flight_data);
        NSLog(@"ICAO: %@",company_data);
        NSLog(@"Destination: %@",destination_data);
        NSLog(@"STD: %@",std_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      flight_data, flightCode,
                      company_data, company,
                      destination_data,destination,
                      std_data, std,
                      nil];
    
        [flightsArray addObject:dictionary];
    
    }
    
        self.jetwayCode.text = jetway_data;
        self.jetwayStatus.text = status_data;
        self.jetwayHzStatus.text = hz_data;
        self.jetwayDGSStatus.text = dgs_data;
        self.jetwayHVACStatus.text = ac_data;
    
    [self.flightsTable reloadData];
    
}

@end


