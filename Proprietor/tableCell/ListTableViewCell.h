//
//  ListTableViewCell.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class repairTableModel;

@interface ListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,copy)NSString *cellId;

-(void)showUiNewsCell:(repairTableModel*)NModel;

@end
