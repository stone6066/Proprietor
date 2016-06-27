//
//  complainListModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "complainListModel.h"

@implementation complainListModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            complainListModel *NM=[[complainListModel alloc]init];
            NM.mendId = [[dict objectForKey:@"mendId"]stringValue];
            NM.mendTitle = [dict objectForKey:@"mendTitle"];
            NM.reportTime =[self stdTimeToStr:[dict objectForKey:@"reportTime"]];
            NM.mendState = [dict objectForKey:@"mendState"];
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
