//
//  mendDetailViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "mendDetailViewController.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"
#import "RatingBar.h"
#import "stdPubFunc.h"

@interface mendDetailViewController ()

@end

@implementation mendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_mendId];
}
-(void)setMendId:(NSString *)mendId{
    _mendId=mendId;
}
-(void)setLType:(NSInteger)lType{
    _lType=lType;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"报修信息";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadVCData:(NSString*)uid {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    //http://localhost:8080/propies/mend/mendinfo?mendId=21
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/mend/mendinfo?mendId=",uid];
    
    NSLog(@"noticestr:%@",urlstr);
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
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              [self loadDetailVc:jsonDic];
                                              
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
 "mendId":21,
 "repairpeople":null,
 "mendType":"3",
 "mendLevel":"1",
 "mendDesc":"测试1",
 "contact":null,
 "phoneNumber":"15004679082",
 "mendState":"1",
 "reportTime":1458009417000,
 "acceptId":null,
 "mendUser":null,
 "acceptTime":null,
 "mendFee":null,
 "materialFee":null,
 "mendTable":null,
 "completeTime":null,
 "returnReason":null,
 "graded":null,
 "roomsId":null,
 "communityId":null,
 "deleteStatus":0,
 "ownerId":356,
 "mendTitle":"测试",
 "mendNo":"BX20160315103657",
 "userId":null
 */
-(void)loadDetailVc:(NSDictionary*)dict{
    
    UITextView *ContentText=[[UITextView alloc]initWithFrame:CGRectMake(0,TopSeachHigh*2, fDeviceWidth, fDeviceHeight-TopSeachHigh*2-60)];
    
    ContentText.textColor=txtColor;
    ContentText.backgroundColor=[UIColor whiteColor];
    ContentText.font=[UIFont systemFontOfSize:13];
    ContentText.editable=NO;
    
    UIView *topTitleVC=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, TopSeachHigh)];
    topTitleVC.backgroundColor=MyGrayColor;
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, fDeviceWidth, 25)];
    titleLbl.textAlignment=UITextAlignmentCenter;
    titleLbl.font=[UIFont systemFontOfSize:18];
    [titleLbl setTextColor:topSearchBgdColor];
    [topTitleVC addSubview:titleLbl];
    
    
    
    UILabel *noticeTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, fDeviceWidth, 25)];
    noticeTime.textAlignment=UITextAlignmentCenter;
    noticeTime.font=[UIFont systemFontOfSize:13];
    [noticeTime setTextColor:txtColor];
    [topTitleVC addSubview:noticeTime];
    
    NSArray *dictArray = [dict objectForKey:@"data"];
    NSString *timestr=@"";
    NSString *person=@"";
    NSString *telstr=@"";
    NSString *grated=@"";
    for (NSDictionary *dicttmp in dictArray) {
        ContentText.text=[dicttmp objectForKey:@"mendDesc"];
        titleLbl.text=[dicttmp objectForKey:@"mendTitle"];
        
        if(![[dicttmp objectForKey:@"reportTime"] isEqual:[NSNull null]])
            timestr=[self stdTimeToStr:[[dicttmp objectForKey:@"reportTime"]stringValue]];
        
        person=[dicttmp objectForKey:@"repairpeople"];
        telstr=[dicttmp objectForKey:@"phoneNumber"];
       
        grated=[dicttmp objectForKey:@"graded"];
    }
    
    noticeTime.text=[NSString stringWithFormat:@"%@ %@",timestr,person];
    
//    stdCallBtn *telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake((fDeviceWidth-180)/2, 42, 180, 25)];
//    
//    [telLbl setLblText:[NSString stringWithFormat:@"%@ %@",@"电话：",telstr]];
//    [topTitleVC addSubview:telLbl];
    [self.view addSubview:topTitleVC];
    [self.view addSubview:ContentText];
    if (_lType==1) {
        NSInteger starNumber=grated.intValue;
        starNumber=starNumber-1;
        if (starNumber<0) {
            starNumber=0;
        }
        [self setStarBar:starNumber];
    }
   
    
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

-(void)setStarBar:(NSInteger)starNum{
    UIView *starVc=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-60, fDeviceWidth, 60)];
    _raBar = [[RatingBar alloc] initWithFrame:CGRectMake(10, 15, 180, 30)];
    [_raBar setStarNumber:starNum];
    [_raBar setViewColor:MyGrayColor];
    [starVc addSubview:_raBar];
    starVc.backgroundColor=MyGrayColor;
    
    CGFloat yy=17;
    UIButton *addReport=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-60, yy, 50, 25)];
    [addReport setTitle:@"评分"forState:UIControlStateNormal];// 添加文字
    addReport.backgroundColor=topSearchBgdColor;
    [addReport.layer setMasksToBounds:YES];
    [addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [starVc addSubview:addReport];
    [self.view addSubview:starVc];
    
    

}

-(void)addReportBtn{
    CGFloat yy=fDeviceHeight-MainTabbarHeight-60;
    UIButton *addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    [addReport setTitle:@"退出登录"forState:UIControlStateNormal];// 添加文字
    addReport.backgroundColor=topSearchBgdColor;
    [addReport.layer setMasksToBounds:YES];
    [addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReport];
    
}


-(void)stdAddClick {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
   //http://192.168.0.21:8080/propies/mend/gradedupdate?mendId=21&graded=3
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%d",BaseUrl,@"propies/mend/gradedupdate?mendId=",_mendId,@"&graded=",_raBar.starNumber+1];
    
    NSLog(@"noticestr:%@",urlstr);
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
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"评分成功"];
                                              
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
@end
