//
//  HomeViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"
#import "ListTableViewCell.h"
#import "repairTableModel.h"
#import "noticeDetailViewController.h"
#import "webViewController.h"

@interface HomeViewController ()
{
    UIButton *back;
    NSMutableArray *_tableDataSource;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableDataSource=[[NSMutableArray alloc]init];
    [self loadTopNav];
    [self loadHomeContent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"首页";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden=YES;
    if (!ApplicationDelegate.isLogin) {
        //显示登录页面
        LoginViewController *vc = [[LoginViewController alloc]init];
        vc.loginSuccBlock = ^(LoginViewController *aqrvc){
            NSLog(@"login_suc");
            [self showTabBar];
            [self loadTableData:ApplicationDelegate.myLoginInfo.communityId  pageNo:1];
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=2*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"首页";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    [self.view addSubview:TopView];
}


-(void)loadHomeContent{
    
    UIView * topAdVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, HomeADHeigh)];
    UIImageView *ADImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, HomeADHeigh)];
    [ADImg sd_setImageWithURL:[NSURL URLWithString:@"http://img-ta-01.b0.upaiyun.com/14423687819335302.jpg"]];
    
    [topAdVc addSubview:ADImg];
    
    UIButton *ADbutton=[[UIButton alloc]init];
    ADbutton.frame=ADImg.frame;
    [topAdVc addSubview:ADbutton];
    [ADbutton addTarget:self action:@selector(adClickBtn) forControlEvents:UIControlEventTouchUpInside];
    topAdVc.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:topAdVc];
    [self loadNoticeTable];
}
-(void)adClickBtn{
    webViewController *webpageVc=[[webViewController alloc]init];
    [webpageVc setWeburl:@"http://www.tao-yx.com/mobile/list/4678"];
    [self.navigationController pushViewController:webpageVc animated:NO];
    NSLog(@"adClickBtn");
}
static NSString * const HomeCellId = @"homeTableCell";
-(void)loadNoticeTable{
    UIView *tableTitle=[[UIView alloc]initWithFrame:CGRectMake(0, HomeADHeigh+TopSeachHigh, fDeviceWidth, 40)];
    UIImageView *titleImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, (40-13)/2, 2, 13)];
    titleImg.image=[UIImage imageNamed:@"verticalLine"];
    [tableTitle addSubview:titleImg];
    UILabel *titleTxt=[[UILabel alloc]initWithFrame:CGRectMake(23, (40-20)/2, 80, 20)];
    titleTxt.text=@"社区公告";
    [titleTxt setTextColor:txtColor];
    
    [tableTitle addSubview:titleTxt];
    [self.view addSubview:tableTitle];
    tableTitle.backgroundColor=MyGrayColor;
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, HomeADHeigh+TopSeachHigh+40, fDeviceWidth, fDeviceHeight-NavTopHight-MainTabbarHeight)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:HomeCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.TableView];
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tableDataSource.count>0) {
            _pageindex+=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        }
        else
        {
            _pageindex=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        }
        
        // 结束刷新
        [weakSelf.TableView.mj_footer endRefreshing];
    }];


}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    repairTableModel *dm=_tableDataSource[indexPath.item];
    [cell showUiNewsCell:dm];
    //    cell.textLabel.text=_tableDataSource[indexPath.item];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    if (_tableDataSource.count) {
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    }else{
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *svc =(ListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    repairTableModel *dm= [svc praseNoticeData:svc];
    
    noticeDetailViewController *noticeVc=[[noticeDetailViewController alloc]init];
    [noticeVc setNoticeId:dm.noticeId];
    //noticeVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:noticeVc animated:NO];
    
}


-(void)loadTableData:(NSString*)uid  pageNo:(NSInteger)pagenum{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    //http://localhost:8080/propies/index/notice?communityId=1&page=1&pagesize=20
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/index/notice?communityId=",uid,@"&page=",(long)pagenum,@"&pagesize=20"];
    NSLog(@"homestr:%@",urlstr);
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
                                              
                                              [SVProgressHUD dismiss];
                                              repairTableModel *SM=[[repairTableModel alloc]init];
                                              NSMutableArray *datatmp=[SM asignModelWithDict:jsonDic];
                                              if (pagenum==1) {
                                                  _tableDataSource=datatmp;
                                              }
                                              else{
                                                  [_tableDataSource addObjectsFromArray:datatmp];
                                              }
                                              [self.TableView reloadData];
                                              
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
