//
//  carSeatModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "carSeatModel.h"

//"parkingId":285,
//"parkingNumber":"6-285",
//"parkingModels":"大众迈腾",
//"parkingLicenseplate":"京PQR453",
//"parkingUseoftime":1467043200000,
//"parkingUsingalong":null,
//"parkingMemo":"超市门口第一个",
//"communityId":6,
//"ownerId":387,
//"userId":2
@implementation carSeatModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            carSeatModel *NM=[[carSeatModel alloc]init];
            NM.parkingId = [[dict objectForKey:@"parkingId"]stringValue];
            NM.parkingNumber = [dict objectForKey:@"parkingNumber"];
            NM.parkingModels = [dict objectForKey:@"parkingModels"];
            NM.parkingLicenseplate = [dict objectForKey:@"parkingLicenseplate"];
            NM.parkingUsingalong = [dict objectForKey:@"parkingUsingalong"];
            NM.parkingMemo = [dict objectForKey:@"parkingMemo"];
            NM.communityId = [[dict objectForKey:@"roomsLivenumber"]stringValue];
            NM.ownerId = [[dict objectForKey:@"ownerId"]stringValue];
            NM.userId = [[dict objectForKey:@"buildingId"]stringValue];
            NM.parkingUseoftime=[self stdTimeToStr:[[dict objectForKey:@"parkingUseoftime"]stringValue]];

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
