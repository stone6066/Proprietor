//
//  baoxiuModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "baoxiuModel.h"

@implementation baoxiuModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            baoxiuModel *NM=[[baoxiuModel alloc]init];
            NM.mendId = [[dict objectForKey:@"mendId"]stringValue];
            NM.mendState = [dict objectForKey:@"mendState"];
            NM.mendTitle = [dict objectForKey:@"mendTitle"];
            if(![[dict objectForKey:@"reportTime"] isEqual:[NSNull null]])
                NM.reportTime=[self stdTimeToStr:[[dict objectForKey:@"reportTime"]stringValue]];

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
