//
//  repairViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface repairViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)UIButton *addReport;
@property(nonatomic,copy)NSString *listType;//0未受理、1已受理



@end
