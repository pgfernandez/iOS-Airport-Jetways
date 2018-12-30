//
//  AERJetway.h
//  AirportSCADA
//
//  Created by Pedro Garcia Fernandez on 27/09/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERJetway : NSObject

@property (nonatomic, strong) NSString *jetwayId;
@property (nonatomic) BOOL status;
@property (nonatomic) BOOL hzStatus;
@property (nonatomic) BOOL acStatus;
@property (nonatomic) BOOL dgsStatus;

//-(id)initWithJetwayId

@end
