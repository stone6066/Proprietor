//
//  familyNumberModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "familyNumberModel.h"

@implementation familyNumberModel

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            familyNumberModel *NM=[[familyNumberModel alloc]init];
            NM.membersId = [[dict objectForKey:@"membersId"]stringValue];
            NM.membersName = [dict objectForKey:@"membersName"];
            NM.membersWorkunit = [dict objectForKey:@"membersWorkunit"];
            NM.membersPhone = [dict objectForKey:@"membersPhone"];
            NM.membersMemo = [dict objectForKey:@"membersMemo"];
            NM.membersBirthday = [dict objectForKey:@"membersBirthday"];
            NM.membersRelationship = [dict objectForKey:@"membersRelationship"];
            NM.ownerId = [[dict objectForKey:@"ownerId"]stringValue];
            
            [arr addObject:NM];
        }
        
    }
    return arr;
}

@end
