//
//  complainTypeModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface complainTypeModel : NSObject
@property (nonatomic,copy)NSString *complaintTypeId;
@property (nonatomic,copy)NSString *complaintTypeName;
@property (nonatomic,copy)NSString *deleteStatus;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
