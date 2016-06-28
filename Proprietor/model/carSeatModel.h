//
//  carSeatModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carSeatModel : NSObject


@property(nonatomic,copy)NSString *parkingId;
@property(nonatomic,copy)NSString *parkingNumber;
@property(nonatomic,copy)NSString *parkingModels;
@property(nonatomic,copy)NSString *parkingLicenseplate;
@property(nonatomic,copy)NSString *parkingUseoftime;
@property(nonatomic,copy)NSString *parkingUsingalong;
@property(nonatomic,copy)NSString *parkingMemo;
@property(nonatomic,copy)NSString *communityId;
@property(nonatomic,copy)NSString *ownerId;
@property(nonatomic,copy)NSString *userId;
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
