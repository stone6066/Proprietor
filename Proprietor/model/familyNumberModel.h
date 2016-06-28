//
//  familyNumberModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface familyNumberModel : NSObject

@property(nonatomic,copy)NSString *membersId;
@property(nonatomic,copy)NSString *membersName;
@property(nonatomic,copy)NSString *membersWorkunit;
@property(nonatomic,copy)NSString *membersPhone;
@property(nonatomic,copy)NSString *membersMemo;
@property(nonatomic,copy)NSString *membersBirthday;
@property(nonatomic,copy)NSString *membersRelationship;
@property(nonatomic,copy)NSString *ownerId;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
