//
//  noticeViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noticeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;

@end
