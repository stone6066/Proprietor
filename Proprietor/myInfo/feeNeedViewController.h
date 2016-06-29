//
//  feeNeedViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RATreeView/RATreeView.h>
@interface feeNeedViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *RaData;
@property (weak, nonatomic) RATreeView *treeView;
@end
