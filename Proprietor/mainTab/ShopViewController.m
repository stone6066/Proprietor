//
//  ShopViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ShopViewController.h"
#import "AppDelegate.h"
#import "PublicDefine.h"
@interface ShopViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    NSInteger backflag;
    UIButton *back;
    UIImageView *backimg;
}


@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadWebView:@"http://www.tao-yx.com/mobile/"];
    // Do any additional setup after loading the view.
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"商家促销";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    
    backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
     back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    
    backimg.hidden=YES;
    back.hidden=YES;
    [self.view addSubview:TopView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"shopCar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"shopCar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"商家促销";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}

-(void) loadWebView:(NSString*)weburl{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight)];
    [webView setDelegate:self];
    NSLog(@"_weburl:%@",weburl);
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:weburl]];
    [webView loadRequest:request];
    [self.view addSubview: webView];
    
    
}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    // NSString *location=webView.request.URL.absoluteString;
    // NSLog(@"webViewUrl:%@",location);
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *location=webView.request.URL.absoluteString;
    NSLog(@"webViewDidFinishLoad:%@",location);

    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    if ([location isEqualToString:[NSString stringWithFormat:@"http://www.tao-yx.com/mobile/"]]) {
        backflag=1;
        
        backimg.hidden=YES;
        back.hidden=YES;
    }
    else
    {
        backflag=0;
        backimg.hidden=NO;
        back.hidden=NO;
    }
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;//return NO 的时候，webview就不会加载页面了
}
-(void)clickleftbtn
{
    if ([webView canGoBack]) {
        [webView goBack];
        NSLog(@"canGoBack");
    }
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"didFailLoadWithError:%@", error);
}

@end
