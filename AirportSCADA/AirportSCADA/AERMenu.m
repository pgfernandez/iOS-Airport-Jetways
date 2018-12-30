//
//  AERMenu.m
//  StarWars
//
//  Created by Pedro Garcia Fernandez on 13/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERMenu.h"

@implementation AERMenu

#pragma mark - Init

-(id) init{
 

    if (self = [super init]){
        
        //Creating the menu
        self.menuOptions = @[@"ENERGY", @"HVAC", @"BHS", @"LIGHTING", @"ELECTROMECHANICS", @"AIR BRIDGES", @"SCENARIOS"];

        
    }
    
    
    return self;
    
}



-(NSUInteger) menuItemsCount{
    return [self.menuOptions count];
}

#pragma mark - Menu Acessors

-(NSString *) menuItemAtIndex:(NSUInteger) index{
    
    return [self.menuOptions objectAtIndex:index];
}


@end
