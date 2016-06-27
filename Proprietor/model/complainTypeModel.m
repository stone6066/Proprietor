//
//  complainTypeModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "complainTypeModel.h"

@implementation complainTypeModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            complainTypeModel *NM=[[complainTypeModel alloc]init];
            NM.complaintTypeId = [[dict objectForKey:@"complaintTypeId"]stringValue];
            NM.complaintTypeName = [dict objectForKey:@"complaintTypeName"];
            [arr addObject:NM];
        }
        
    }
    return arr;
}

@end
