//
//  loginInfo.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "loginInfo.h"

//@property(nonatomic,copy)NSString *ownerId;
//@property(nonatomic,copy)NSString *ownerName;
//@property(nonatomic,copy)NSString *ownerPhone;
//@property(nonatomic,copy)NSString *ownerWorkunit;//工作单位
//@property(nonatomic,copy)NSString *ownerBirthday;//业主生日
//@property(nonatomic,copy)NSString *ownerMemo;
//@property(nonatomic,copy)NSString *ownerMembersnumber;//家庭成员数量
//@property(nonatomic,copy)NSString *userId;
//@property(nonatomic,copy)NSString *communityId;//小区id


@implementation loginInfo
- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict{
    
    NSArray *dictArray = [dict objectForKey:@"data"];
    loginInfo *LGInfo=[[loginInfo alloc]init];
    
    for (NSDictionary *dicttmp in dictArray) {
        
    
    LGInfo.ownerId=[[dicttmp objectForKey:@"ownerId"]stringValue];
    LGInfo.ownerName=[dicttmp objectForKey:@"ownerName"];
    LGInfo.ownerPhone=[dicttmp objectForKey:@"ownerPhone"];
    LGInfo.ownerWorkunit=[dicttmp objectForKey:@"ownerWorkunit"];
    //LGInfo.ownerBirthday=[dictArray[@"ownerBirthday"]stringValue];
    LGInfo.ownerMemo=[dicttmp objectForKey:@"ownerMemo"];
    LGInfo.ownerMembersnumber=[[dicttmp objectForKey:@"ownerMembersnumber"]stringValue];
    LGInfo.userId=[[dicttmp objectForKey:@"userId"]stringValue];
    LGInfo.communityId=[[dicttmp objectForKey:@"communityId"]stringValue];
    
    if(![[dicttmp objectForKey:@"ownerBirthday"] isEqual:[NSNull null]])
         LGInfo.ownerBirthday=[self stdTimeToStr:[[dicttmp objectForKey:@"ownerBirthday"]stringValue]];
    }
    //NSLog(@"ownerId:%@",LGInfo.ownerId);
    return LGInfo;
    
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}
@end
