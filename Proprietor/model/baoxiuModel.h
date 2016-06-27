//
//  baoxiuModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baoxiuModel : NSObject
@property (nonatomic,copy)NSString *mendId;
@property (nonatomic,copy)NSString *reportTime;
@property (nonatomic,copy)NSString *mendTitle;
@property (nonatomic,copy)NSString *mendState;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
