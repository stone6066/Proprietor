//
//  contactUsViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "contactUsViewController.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"

@interface contactUsViewController ()

@end

@implementation contactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self loadContentView:@"13800138000" contact:@"程经理" address:@"金凤区新华南路109号"];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadTableData:ApplicationDelegate.myLoginInfo.communityId];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadContentView:(NSString*)tel contact:(NSString*)names address:(NSString*)addrstr{
    CGFloat lineHeigh=40;
    UIView * contentVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 130)];
    _telImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 16, 16)];
    _contactImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12+lineHeigh, 16, 16)];
    _addrImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12+lineHeigh*2, 16, 16)];
    
    _telImg.image=[UIImage imageNamed:@"tel"];
    _contactImg.image=[UIImage imageNamed:@"contact"];
    _addrImg.image=[UIImage imageNamed:@"addr"];
    [contentVc addSubview:_telImg];
    [contentVc addSubview:_contactImg];
    [contentVc addSubview:_addrImg];
    
    
    _telTitle=[[UILabel alloc]initWithFrame:CGRectMake(36, 10, 80, 20)];
    _contactTitle=[[UILabel alloc]initWithFrame:CGRectMake(36, 10+lineHeigh, 80, 20)];
    _addrTitle=[[UILabel alloc]initWithFrame:CGRectMake(36, 10+lineHeigh*2, 80, 20)];
    _telTitle.text=@"报修电话：";
    _contactTitle.text=@"联系人：";
    _addrTitle.text=@"物业地址：";
    
    [_telTitle setFont:[UIFont systemFontOfSize:13]];
    [_contactTitle setFont:[UIFont systemFontOfSize:13]];
    [_addrTitle setFont:[UIFont systemFontOfSize:13]];
    [contentVc addSubview:_telTitle];
    [contentVc addSubview:_contactTitle];
    [contentVc addSubview:_addrTitle];
    
    CGFloat lineWidth=tel.length*20;
    _telTxt=[[stdCallBtn alloc]initWithFrame:CGRectMake(100, 10, lineWidth, 20)];
    
    lineWidth=names.length*20;
    _contactTxt=[[UILabel alloc]initWithFrame:CGRectMake(86, 10+lineHeigh, lineWidth, 20)];
    
    lineWidth=addrstr.length*20;
    _addrTxt=[[UILabel alloc]initWithFrame:CGRectMake(100, 10+lineHeigh*2, lineWidth, 20)];
    [_telTxt setLblText:tel];
    _contactTxt.text=names;
    _addrTxt.text=addrstr;
    
    
    [_contactTxt setFont:[UIFont systemFontOfSize:13]];
    [_addrTxt setFont:[UIFont systemFontOfSize:13]];
    [contentVc addSubview:_telTxt];
    [contentVc addSubview:_contactTxt];
    [contentVc addSubview:_addrTxt];
    
    contentVc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:contentVc];
    
}
-(void)loadTableData:(NSString*)uid{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    //http://192.168.0.21:8080/propies/owner/communityinfo?communityId=6
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/owner/communityinfo?communityId=",uid];
    //NSLog(@"urlstr:%@",urlstr);
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"result"];
                                          
                                          //
                                          if ([suc isEqualToString:@"true"]) {
                                              //成功
                                             
                                              NSArray *dictArray = [jsonDic objectForKey:@"data"];
                                              if(![[jsonDic objectForKey:@"data"] isEqual:[NSNull null]])
                                              {
                                                  
                                                  for (NSDictionary *dict in dictArray) {
                                                      [self loadContentView:[dict objectForKey:@"coummunityPhone"] contact:[dict objectForKey:@"coummunityAdmin"] address:[dict objectForKey:@"communityAddress"]];
                                                     
                                                  }
                                                  
                                              }

                                              [SVProgressHUD dismiss];
                                              
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                              
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      
                                  }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
