//
//  ListTableViewCell.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class repairTableModel,baoxiuModel,complainListModel;

@interface ListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *timeLbl;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,copy)NSString *cellId;
@property(nonatomic,copy)NSString *noticeContent;
@property(nonatomic,copy)NSString *createTime;
-(void)showUiNewsCell:(repairTableModel*)NModel;
-(void)showUiBaoxiuCell:(baoxiuModel*)NModel;
-(void)showUiComplainCell:(complainListModel*)NModel;
-(repairTableModel*)praseNoticeData:(ListTableViewCell *)LVC;
-(baoxiuModel*)praseBaoxiuData:(ListTableViewCell *)LVC;
@end
