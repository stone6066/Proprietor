//
//  carRoomModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "carRoomModel.h"
//"garageId":2,
//"garageNumber":"ck0001",
//"garageArea":"1000",
//"garageAlone":1,
//"communityId":6,
//"buildingId":14,
//"garageMemo":"测试",
//"ownerId":356,
//"userId":2
@implementation carRoomModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            carRoomModel *NM=[[carRoomModel alloc]init];
            NM.garageId = [[dict objectForKey:@"garageId"]stringValue];
            NM.garageNumber = [dict objectForKey:@"garageNumber"];
            NM.garageArea = [dict objectForKey:@"garageArea"];
            NM.garageAlone = [[dict objectForKey:@"garageAlone"]stringValue];
            NM.communityId = [[dict objectForKey:@"communityId"]stringValue];
            NM.buildingId = [[dict objectForKey:@"buildingId"]stringValue];
            NM.garageMemo = [dict objectForKey:@"garageMemo"];
            NM.ownerId = [[dict objectForKey:@"ownerId"]stringValue];
            NM.userId = [[dict objectForKey:@"buildingId"]stringValue];
            
            
            [arr addObject:NM];
        }
        
    }
    return arr;
}

@end
