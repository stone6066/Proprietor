//
//  contactUsViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class stdCallBtn;

@interface contactUsViewController : UIViewController
@property(nonatomic,strong)UILabel *telTitle;
@property(nonatomic,strong)stdCallBtn *telTxt;
@property(nonatomic,strong)UILabel *contactTitle;
@property(nonatomic,strong)UILabel *contactTxt;
@property(nonatomic,strong)UILabel *addrTitle;
@property(nonatomic,strong)UILabel *addrTxt;

@property(nonatomic,strong)UIImageView *telImg;
@property(nonatomic,strong)UIImageView *contactImg;
@property(nonatomic,strong)UIImageView *addrImg;
@end
