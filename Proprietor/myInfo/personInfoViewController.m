//
//  personInfoViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "personInfoViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "personInfoMode.h"
#import "RADataObject.h"
#import "RATableViewCell.h"
#import "stdCallBtn.h"
#import "familyNumberModel.h"

@interface personInfoViewController ()<RATreeViewDelegate, RATreeViewDataSource>
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation personInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableDataSource=[[NSMutableArray alloc]init];
    _RaData=[[NSMutableArray alloc]init];
    self.view.backgroundColor=MyGrayColor;
    _showType=0;
    [self loadTopNav];
    [self drawSegmentedView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
[self loadPersonContent];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"个人信息";
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


-(void)drawSegmentedView{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"基础信息",@"家庭成员",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    CGFloat sgWidth=fDeviceWidth-80;
    segmentedControl.frame = CGRectMake(40,TopSeachHigh+10,sgWidth,30);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = topSearchBgdColor;
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    [_contentVc removeFromSuperview];
    switch (Index) {
        case 0:
            
            [self loadPersonContent];
            break;
        case 1:
            [self loadTableData:ApplicationDelegate.myLoginInfo.ownerId];
            break;
            
        default:
            break;
    }
    _showType=Index;
}

-(void)loadPersonContent{
    personInfoMode *PM=[[personInfoMode alloc]init];
    PM.name=ApplicationDelegate.myLoginInfo.ownerName;
    PM.telphone=ApplicationDelegate.myLoginInfo.ownerPhone;
    NSInteger typeId=[ApplicationDelegate.myLoginInfo.documenttypeId integerValue];
    if (typeId==1) {
        PM.cardType=@"身份证";
    }
    else
        PM.cardType=@"其他";
    
    PM.cardNum=ApplicationDelegate.myLoginInfo.ownerDocumentnumber;
    PM.birthday=ApplicationDelegate.myLoginInfo.ownerBirthday;
    PM.workInfo=ApplicationDelegate.myLoginInfo.ownerWorkunit;
    
    _contentVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+50, fDeviceWidth, 310)];
   
    CGFloat firstY=0;
    CGRect firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *personInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"contact" titleName:@"姓       名：" txtName:PM.name lookImg:@"" sendid:1];
    [_contentVc addSubview:personInfo];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *telInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"tel" titleName:@"联系电话：" txtName:@"" lookImg:@"" sendid:1];
    [_contentVc addSubview:telInfo];
    
    _telTxt=[[stdCallBtn alloc]initWithFrame:CGRectMake(125, firstY, 150, 50)];
    [_telTxt setLblText:PM.telphone];
    [_contentVc addSubview:_telTxt];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *cardType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"personInfo" titleName:@"证件类型：" txtName:PM.cardType lookImg:@"" sendid:1];
    [_contentVc addSubview:cardType];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *cardNum=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"card" titleName:@"证件号码：" txtName:PM.cardNum lookImg:@"" sendid:1];
    [_contentVc addSubview:cardNum];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *birthday=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"date" titleName:@"出生日期：" txtName:PM.birthday lookImg:@"" sendid:1];
    [_contentVc addSubview:birthday];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *workinfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"workCompany" titleName:@"工作单位：" txtName:PM.workInfo lookImg:@"" sendid:1];
    [_contentVc addSubview:workinfo];
    
    [self.view addSubview:_contentVc];
}

-(void)loadFamliyNumbers{
   
     _contentVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+50, fDeviceWidth, fDeviceHeight-TopSeachHigh-50-50)];
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-TopSeachHigh-50-50)];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
    [treeView.scrollView addSubview:refreshControl];
    
    [treeView reloadData];
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    
    
    self.treeView = treeView;
    self.treeView.frame = CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-TopSeachHigh-50-50);
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_contentVc insertSubview:treeView atIndex:0];
    
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = NSLocalizedString(@"Things", nil);
    //[self updateNavigationItemButton];
    
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([RATableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RATableViewCell class])];
    [self.view addSubview:_contentVc];
}




- (void)refreshControlChanged:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}
#pragma mark - Helpers

- (void)loadData
{
    [_RaData removeAllObjects];
    for (familyNumberModel *familyObj in _tableDataSource) {
       
        RADataObject *Raobj1 = [RADataObject dataObjectWithName:[NSString stringWithFormat:@"%@%@",@"电话：",familyObj.membersPhone] children:nil];
        RADataObject *Raobj2 = [RADataObject dataObjectWithName:[NSString stringWithFormat:@"%@%@",@"出生日期：",familyObj.membersBirthday] children:nil];
        RADataObject *Raobj3 = [RADataObject dataObjectWithName:[NSString stringWithFormat:@"%@%@",@"工作单位：",familyObj.membersWorkunit] children:nil];
        RADataObject *Raobj4 = [RADataObject dataObjectWithName:[NSString stringWithFormat:@"%@%@",@"与业主关系：",familyObj.membersRelationship] children:nil];
        
        RADataObject *Raobj = [RADataObject dataObjectWithName:familyObj.membersName
                                                         children:[NSArray arrayWithObjects:Raobj1, Raobj2, Raobj3,Raobj4, nil]];
        [_RaData addObject:Raobj];
    }
    [self loadFamliyNumbers];
}

#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item
{
    return YES;
}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:YES animated:YES];
}

- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item
{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
    RADataObject *parent = [self.treeView parentForItem:item];
    NSInteger index = 0;
    
    if (parent == nil) {
        index = [self.RaData indexOfObject:item];
        NSMutableArray *children = [self.RaData mutableCopy];
        [children removeObject:item];
        self.RaData = [children copy];
        
    } else {
        index = [parent.children indexOfObject:item];
        [parent removeChild:item];
    }
    
    [self.treeView deleteItemsAtIndexes:[NSIndexSet indexSetWithIndex:index] inParent:parent withAnimation:RATreeViewRowAnimationRight];
    if (parent) {
        [self.treeView reloadRowsForItems:@[parent] withRowAnimation:RATreeViewRowAnimationNone];
    }
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    RADataObject *dataObject = item;
    //NSInteger cellIndex=[_RaData indexOfObject:dataObject];
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    RATableViewCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([RATableViewCell class])];
    NSString *iconview;
    if (level==0) {
        iconview=@"contact";
        
        [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded iocnName:iconview isPhone:1];
    }
    else
    {
        iconview=@"verticalLine";
        NSRange range = [dataObject.name rangeOfString:@"电话："];//判断字符串是否包含
        if (range.length >0)//包含
        {
            [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded iocnName:iconview isPhone:0];
            
            
        }
        else//不包含
        {
            [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded iocnName:iconview isPhone:1];
        }
        
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    cell.additionButtonTapAction = ^(id sender){
        if (![weakSelf.treeView isCellForItemExpanded:dataObject] || weakSelf.treeView.isEditing) {
            return;
        }
        RADataObject *newDataObject = [[RADataObject alloc] initWithName:@"Added value" children:@[]];
        [dataObject addChild:newDataObject];
        [weakSelf.treeView insertItemsAtIndexes:[NSIndexSet indexSetWithIndex:0] inParent:dataObject withAnimation:RATreeViewRowAnimationLeft];
        [weakSelf.treeView reloadRowsForItems:@[dataObject] withRowAnimation:RATreeViewRowAnimationNone];
    };
    
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.RaData count];
    }
    
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.RaData objectAtIndex:index];
    }
    
    return data.children[index];
}




-(void)loadTableData:(NSString*)uid {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/owner/membersinfo?ownerId=",uid];
    
    NSLog(@"complainstr:%@",urlstr);
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
                                              familyNumberModel *SM=[[familyNumberModel alloc]init];
                                              _tableDataSource=[SM asignModelWithDict:jsonDic];
                                              [self loadData];
                                              
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
