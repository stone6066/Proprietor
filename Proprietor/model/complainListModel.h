//
//  complainListModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface complainListModel : NSObject
@property (nonatomic,copy)NSString *complaintId;
@property (nonatomic,copy)NSString *complaintContent;
@property (nonatomic,copy)NSString *complaintCreatetime;
@property (nonatomic,copy)NSString *communityId;
@property (nonatomic,copy)NSString *complaintStatusName;
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
