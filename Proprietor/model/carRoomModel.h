//
//  carRoomModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carRoomModel : NSObject


@property(nonatomic,copy)NSString *garageId;
@property(nonatomic,copy)NSString *garageNumber;
@property(nonatomic,copy)NSString *garageArea;
@property(nonatomic,copy)NSString *garageAlone;
@property(nonatomic,copy)NSString *communityId;
@property(nonatomic,copy)NSString *buildingId;
@property(nonatomic,copy)NSString *garageMemo;
@property(nonatomic,copy)NSString *ownerId;
@property(nonatomic,copy)NSString *userId;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
