//
//  complainViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//  物业投诉

#import <UIKit/UIKit.h>

@interface complainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)UIButton *addReport;
@property(nonatomic,assign)NSInteger listType;//0未受理、1已受理

@end
