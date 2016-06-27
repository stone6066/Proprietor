//
//  loginInfo.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginInfo : NSObject
@property(nonatomic,copy)NSString *ownerId;
@property(nonatomic,copy)NSString *ownerName;
@property(nonatomic,copy)NSString *ownerPhone;
@property(nonatomic,copy)NSString *ownerWorkunit;//工作单位
@property(nonatomic,copy)NSString *ownerBirthday;//业主生日
@property(nonatomic,copy)NSString *ownerMemo;
@property(nonatomic,copy)NSString *ownerMembersnumber;//家庭成员数量
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *communityId;//小区id

- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict;
@end
