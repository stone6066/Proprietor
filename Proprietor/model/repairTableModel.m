//
//  repairTableModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "repairTableModel.h"

@implementation repairTableModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            repairTableModel *NM=[[repairTableModel alloc]init];
            NM.title = dict[@"goodsTitle"];
            NM.imageurl=dict[@"goodsPicUrl"];
            NM.cellId=dict[@"goodsInfoMobileUrl"];
            [arr addObject:NM];
        }
    }
    return arr;
}
@end
