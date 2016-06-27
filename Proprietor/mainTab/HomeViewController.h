//
//  HomeViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* TableView;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,assign)NSInteger pageindex;
@end
