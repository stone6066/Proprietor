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


@interface personInfoViewController ()<RATreeViewDelegate, RATreeViewDataSource>

@end

@implementation personInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    _showType=0;
    [self loadTopNav];
    [self drawSegmentedView];
    [self loadPersonContent];
    // Do any additional setup after loading the view.
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
            [self loadFamliyNumbers];
            break;
            
        default:
            break;
    }
    _showType=Index;
}

-(void)loadPersonContent{
    personInfoMode *PM=[[personInfoMode alloc]init];
    PM.name=@"斯蒂芬";
    PM.telphone=@"13796224528";
    PM.cardType=@"身份证";
    PM.cardNum=@"231023198312092215";
    PM.birthday=@"1989-09-21";
    PM.workInfo=@"天安在线信息技术有限公司";
    
    _contentVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+50, fDeviceWidth, 310)];
   
    CGFloat firstY=0;
    CGRect firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *personInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"contact" titleName:@"姓       名：" txtName:PM.name lookImg:@"" sendid:1];
    [_contentVc addSubview:personInfo];
    
    firstY=firstY+51;
    firstCG=CGRectMake(0, firstY, fDeviceWidth, 50);
    stdCellVc *telInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"tel" titleName:@"联系电话：" txtName:PM.telphone lookImg:@"" sendid:1];
    [_contentVc addSubview:telInfo];
    
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
    [self loadData];
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


//- (void)updateNavigationItemButton
//{
//    UIBarButtonSystemItem systemItem = self.treeView.isEditing ? UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit;
//    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(editButtonTapped:)];
//    self.navigationItem.rightBarButtonItem = self.editButton;
//}

//- (void)editButtonTapped:(id)sender
//{
//    [self.treeView setEditing:!self.treeView.isEditing animated:YES];
//    [self updateNavigationItemButton];
//}

- (void)refreshControlChanged:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}
#pragma mark - Helpers

- (void)loadData
{
    RADataObject *phone1 = [RADataObject dataObjectWithName:@"电话：13798098876" children:nil];
    RADataObject *phone2 = [RADataObject dataObjectWithName:@"出生日期：1989-09-08" children:nil];
    RADataObject *phone3 = [RADataObject dataObjectWithName:@"单位：阿里巴巴（中国）投资股份有限公司" children:nil];
    RADataObject *phone4 = [RADataObject dataObjectWithName:@"与业主关系：夫妻" children:nil];
    
    RADataObject *phone = [RADataObject dataObjectWithName:@"刘伟"
                                                  children:[NSArray arrayWithObjects:phone1, phone2, phone3, phone4, nil]];
    
   
    
    RADataObject *computer1 = [RADataObject dataObjectWithName:@"电话：13798098876"children:nil];
    RADataObject *computer2 = [RADataObject dataObjectWithName:@"出生日期：1989-09-08" children:nil];
    RADataObject *computer3 = [RADataObject dataObjectWithName:@"单位：阿里巴巴（中国）投资股份有限公司" children:nil];
    RADataObject *computer4 = [RADataObject dataObjectWithName:@"与业主关系：父子" children:nil];
    RADataObject *computer = [RADataObject dataObjectWithName:@"马航"
                                                     children:[NSArray arrayWithObjects:computer1, computer2, computer3,computer4, nil]];
   
    
    self.data = [NSArray arrayWithObjects:phone, computer,  nil];
    
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
        index = [self.data indexOfObject:item];
        NSMutableArray *children = [self.data mutableCopy];
        [children removeObject:item];
        self.data = [children copy];
        
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
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    RATableViewCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([RATableViewCell class])];
   NSString *iconview;
    if (level==0) {
        iconview=@"contact";
    }
    else
        iconview=@"verticalLine";
    
    [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded iocnName:iconview];
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
        return [self.data count];
    }
    
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return data.children[index];
}


@end
