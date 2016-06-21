//
//  repairTableModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface repairTableModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *imageurl;
@property (nonatomic,copy)NSString *cellId;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
