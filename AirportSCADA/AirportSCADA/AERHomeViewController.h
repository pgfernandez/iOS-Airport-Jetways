//
//  AERHomeViewController.h
//  AirportSCADA
//
//  Created by Pedro Garcia Fernandez on 16/08/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AERMenu.h"

@protocol AERHomeViewControllerDelegate <NSObject>

- (void) didSelectMenuItem:(NSString*)menuItem;


@end

@interface AERHomeViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITableView *systemsTable;
@property (weak, nonatomic) IBOutlet UITableView *flightsTable;
@property (weak, nonatomic) IBOutlet UIView *detailSystemsView;
@property (weak, nonatomic) id<AERHomeViewControllerDelegate>delegate;
@property (strong, nonatomic)AERMenu *model;

//jetways
@property (weak, nonatomic) IBOutlet UIButton *jetwayA01;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA02;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA03;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA04;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA05;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA06;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA07;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA08;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA09;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA10;
@property (weak, nonatomic) IBOutlet UIButton *jetwayA11;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB01;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB02;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB03;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB04;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB05;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB06;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB07;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB08;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB09;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB10;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB11;
@property (weak, nonatomic) IBOutlet UIButton *jetwayB12;

@property (weak, nonatomic) IBOutlet UILabel *jetwayCode;
@property (weak, nonatomic) IBOutlet UILabel *jetwayHzStatus;
@property (weak, nonatomic) IBOutlet UILabel *jetwayDGSStatus;
@property (weak, nonatomic) IBOutlet UILabel *jetwayStatus;
@property (weak, nonatomic) IBOutlet UILabel *jetwayHVACStatus;

@end
