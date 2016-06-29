//
//  feeModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "feeModel.h"

//"shangqiQK":0,
//"shangqiFK":0,
//"benqiJS":0,
//"benqiFK":0,
//"benqiHS":0

@implementation feeModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            feeModel *NM=[[feeModel alloc]init];
            NM.shangqiQK = [[dict objectForKey:@"shangqiQK"]stringValue];
            NM.shangqiFK = [[dict objectForKey:@"shangqiFK"]stringValue];
            NM.benqiJS = [[dict objectForKey:@"benqiJS"]stringValue];
            NM.benqiFK = [[dict objectForKey:@"benqiFK"]stringValue];
            NM.benqiHS = [[dict objectForKey:@"benqiHS"]stringValue];
            
            [arr addObject:NM];
        }
        
    }
    return arr;
}

@end
