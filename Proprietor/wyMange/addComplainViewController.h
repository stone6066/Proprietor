//
//  addComplainViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addComplainViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UILabel *repairType;//报修类型
@property(nonatomic,strong)UITextField *repaitText;//内容
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *pView;


@end
