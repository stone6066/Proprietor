//
//  personInfoViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RATreeView/RATreeView.h>

@interface personInfoViewController : UIViewController
@property(nonatomic,strong)UIView *contentVc;
@property(nonatomic,assign)NSInteger showType;//0当前显示基础信息  1当前显示家庭成员

@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) RATreeView *treeView;
@property (strong, nonatomic) UIBarButtonItem *editButton;
@end
