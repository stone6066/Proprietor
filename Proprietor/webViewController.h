//
//  webViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,assign)NSInteger scanFlag;//扫二维码按钮是否可用
@property(nonatomic,strong)UIButton *scanBtn;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
-(void)setWeburl:(NSString *)weburl;

@end
