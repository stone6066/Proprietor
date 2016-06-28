//
//  ownerRoomModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ownerRoomModel.h"

@implementation ownerRoomModel
//"roomsId":2077,
//"roomsNumber":"6-14-1-1501",
//"roomsUnit":"1",
//"roomsLayers":15,
//"roomsBuilding":"1501",
//"roomsBuildingarea":"74",
//"roomsUsearea":"47",
//"roomsPattern":"两室一厅",
//"roomsMemo":"测试茯",
//"roomsLivenumber":2,
//"roomsStatus":0,
//"buildingId":14,
//"ownerId":387,
//"roomsTypeId":1,
//"roomsCheckintime":1451750400000,
//"roomsPassword":"25d55ad283aa400af464c76d713c07ad"
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            ownerRoomModel *NM=[[ownerRoomModel alloc]init];
            NM.roomsId = [[dict objectForKey:@"roomsId"]stringValue];
            NM.roomsNumber = [dict objectForKey:@"roomsNumber"];
            NM.roomsUnit = [dict objectForKey:@"roomsUnit"];
            NM.roomsLayers = [dict objectForKey:@"roomsLayers"];
            NM.roomsBuilding = [dict objectForKey:@"roomsBuilding"];
            NM.roomsBuildingarea = [dict objectForKey:@"roomsBuildingarea"];
            NM.roomsUsearea = [dict objectForKey:@"roomsUsearea"];
            NM.roomsPattern = [dict objectForKey:@"roomsPattern"];
            NM.roomsMemo = [dict objectForKey:@"roomsMemo"];
            NM.roomsLivenumber = [[dict objectForKey:@"roomsLivenumber"]stringValue];
            NM.roomsStatus = [[dict objectForKey:@"roomsStatus"]stringValue];
            NM.buildingId = [[dict objectForKey:@"buildingId"]stringValue];
            NM.roomsTypeId = [[dict objectForKey:@"roomsTypeId"]stringValue];
           
            NM.roomsCheckintime=[self stdTimeToStr:[[dict objectForKey:@"roomsCheckintime"]stringValue]];
            NM.roomsPassword = [dict objectForKey:@"roomsPassword"];
            NM.ownerId = [[dict objectForKey:@"ownerId"]stringValue];
            
            [arr addObject:NM];
        }
        
    }
    return arr;
}
-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}
@end
