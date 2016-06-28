//
//  ownerRoomModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ownerRoomModel : NSObject

@property(nonatomic,copy)NSString *roomsId;
@property(nonatomic,copy)NSString *roomsNumber;
@property(nonatomic,copy)NSString *roomsUnit;
@property(nonatomic,copy)NSString *roomsLayers;
@property(nonatomic,copy)NSString *roomsBuilding;
@property(nonatomic,copy)NSString *roomsBuildingarea;
@property(nonatomic,copy)NSString *roomsUsearea;
@property(nonatomic,copy)NSString *roomsMemo;
@property(nonatomic,copy)NSString *roomsLivenumber;
@property(nonatomic,copy)NSString *roomsStatus;
@property(nonatomic,copy)NSString *buildingId;
@property(nonatomic,copy)NSString *ownerId;
@property(nonatomic,copy)NSString *roomsTypeId;
@property(nonatomic,copy)NSString *roomsCheckintime;
@property(nonatomic,copy)NSString *roomsPassword;
@property(nonatomic,copy)NSString *roomsPattern;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
