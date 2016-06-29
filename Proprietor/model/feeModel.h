//
//  feeModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface feeModel : NSObject
@property(nonatomic,copy)NSString *shangqiQK;//上期欠费
@property(nonatomic,copy)NSString *shangqiFK;//上期付款
@property(nonatomic,copy)NSString *benqiJS;//本期结算
@property(nonatomic,copy)NSString *benqiFK;//本期付款
@property(nonatomic,copy)NSString *benqiHS;//本期核算

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
