//
//  carRoomViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RATreeView/RATreeView.h>
@interface carRoomViewController : UIViewController
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) RATreeView *treeView;
@end
