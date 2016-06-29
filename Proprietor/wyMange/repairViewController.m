//
//  repairViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/16.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "repairViewController.h"
#import "PublicDefine.h"
#import "ListTableViewCell.h"
#import "baoxiuModel.h"
#import "addRepairViewController.h"
#import "mendDetailViewController.h"
@interface repairViewController ()
{
    NSMutableArray *lblArr;
    NSMutableArray *viewArr;
    NSMutableArray *lineArr;
    NSMutableArray *_tableDataSource;
    NSInteger _pageindex;
   
}
@end

@implementation repairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblArr=[[NSMutableArray alloc]init];
    viewArr=[[NSMutableArray alloc]init];
    lineArr=[[NSMutableArray alloc]init];
   
    _pageindex=0;
    _tableDataSource=[[NSMutableArray alloc]init];
     NSArray *arrtitle=[[NSArray alloc]initWithObjects:@"未受理报修", @"已受理报修",nil];
    [self loadTabbar:arrtitle selectedindex:0];
    [self addReportBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    _pageindex=1;
    _listType=0;
    [self loadTableView];
}
//自定义底部tabbar
-(void)loadTabbar:(NSArray*)btn_arr selectedindex:(NSInteger)index{
    UIView *tabbar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 40)];
    float btnwidth=fDeviceWidth/btn_arr.count;
    float lblwidth=0;
    NSString *strtmp=nil;
    for (int i=0; i<2; i++) {
        strtmp=[btn_arr objectAtIndex:i];
        lblwidth=strtmp.length*20;
        
        UILabel *btn_txt=[[UILabel alloc]initWithFrame:CGRectMake((btnwidth-lblwidth)/2, 8, lblwidth, 25)];
        [btn_txt setText:strtmp];
        btn_txt.font=[UIFont systemFontOfSize:14];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnwidth, 40)];
        btn.tag=i;
        [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 38, btnwidth, 2)];
        
        lineView.tag=i;
        
        UIView *btnView=[[UIView alloc]initWithFrame:CGRectMake(btnwidth*i, 0, btnwidth, 40)];
        [btnView addSubview:btn_txt];
        [btnView addSubview:btn];
        [btnView addSubview:lineView];
        btnView.tag=i;
        
        
        
        
        [viewArr addObject:btnView];
        [lblArr addObject:btn_txt];
        [lineArr addObject:lineView];
        btnView.backgroundColor=MyGrayColor;
        if (index==i) {
            lineView.backgroundColor=topSearchBgdColor;
            [btn_txt setTextColor:topSearchBgdColor];
        }
        else
        {
            lineView.backgroundColor=spritLineColor;
            [btn_txt setTextColor:txtColor];
        }
        [tabbar addSubview:btnView];
        //[tabbar addSubview:btn];
    }
    
    //tabbar.backgroundColor=[UIColor redColor];
    [self.view addSubview:tabbar];
}

-(void)tabClick:(UIButton*)sender{
    for (int i=0; i<2; i++)
    {
        UILabel *lbl=(UILabel *)lblArr[i];
        UIView *line=(UIView *)lineArr[i];
        if (i==sender.tag) {
            [lbl setTextColor:topSearchBgdColor];
            line.backgroundColor=topSearchBgdColor;
        }
        else
        {
            [lbl setTextColor:txtColor];
            line.backgroundColor=spritLineColor;
        }
    }
    [_tableDataSource removeAllObjects];
    if (sender.tag==0) {//未受理
        _listType=0;
        _pageindex=1;
        _addReport.hidden=NO;
        [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
            }
    else{
        _listType=1;
        _pageindex=1;
        _addReport.hidden=YES;
        [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
    }
    NSLog(@"%ld",sender.tag);
    
}


-(void)addReportBtn{
    CGFloat yy=fDeviceHeight-NavTopHight-200+50+20;
    _addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    [_addReport setTitle:@"添加报修"forState:UIControlStateNormal];// 添加文字
    _addReport.backgroundColor=topSearchBgdColor;
    [_addReport.layer setMasksToBounds:YES];
    [_addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [_addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addReport];

}
-(void)stdAddClick{
    addRepairViewController *addView=[[addRepairViewController alloc]init];
    addView.hidesBottomBarWhenPushed=YES;
    addView.navigationItem.hidesBackButton=YES;
    [self.navigationController pushViewController:addView animated:NO];
    NSLog(@"添加报事");
}
#pragma mark -loadTableView

static NSString * const MarketCellId = @"repairTableCell";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 41, fDeviceWidth, fDeviceHeight-NavTopHight-200)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.TableView];
    
    _pageindex=1;
    _listType=0;
    [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
    //[self loadTableData:@"uid" typeStr:_listType pageNo:_pageindex];
    
    
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tableDataSource.count>0) {
            _pageindex+=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
        }
        else
        {
            _pageindex=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId pageNo:_pageindex];
        }
        
        // 结束刷新
        [weakSelf.TableView.mj_footer endRefreshing];
    }];
    
    
    //[self addReportBtn];

}
#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    baoxiuModel *dm=_tableDataSource[indexPath.item];
    [cell showUiBaoxiuCell:dm];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *svc =(ListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    baoxiuModel *dm= [svc praseBaoxiuData:svc];
    
    mendDetailViewController *mendVc=[[mendDetailViewController alloc]init];
    [mendVc setMendId:dm.mendId];
    //noticeVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:mendVc animated:NO];
    
}


-(void)loadTableData:(NSString*)uid pageNo:(NSInteger)pagenum{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    
    NSString *urlstr=@"";
    if (_listType==0) {
         urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/mend/notaccept?ownerId=",uid,@"&page=",(long)pagenum,@"&pagesize=20"];
    }
    else
        urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/mend/accept?ownerId=",uid,@"&page=",(long)pagenum,@"&pagesize=20"];
    NSLog(@"baoxiuurlstr:%@",urlstr);
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
                                              baoxiuModel *SM=[[baoxiuModel alloc]init];
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
