//
//  MyInfoViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyInfoViewController.h"
#import "AppDelegate.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "personInfoViewController.h"
#import "HomeInfoViewController.h"
#import "carRoomViewController.h"
#import "carSeatViewController.h"
#import "feeNeedViewController.h"
@interface MyInfoViewController ()<StdButtonDelegate>

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadMyInfoView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=2*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"设置";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    [self.view addSubview:TopView];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"myInfo_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"myInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString *tittxt=@"设置";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
        
        
    }
    return self;
}
-(void)loadMyInfoView{
    CGRect firstCG=CGRectMake(0, TopSeachHigh+30, fDeviceWidth, 50);
    stdCellVc *personInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"personInfo" titleName:@"个人信息" txtName:@"" lookImg:@"rightArrow" sendid:1];
    [self.view addSubview:personInfo];
    
    firstCG=CGRectMake(0, TopSeachHigh+100, fDeviceWidth, 50);
    stdCellVc *room=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"room" titleName:@"房屋信息" txtName:@"" lookImg:@"rightArrow" sendid:2];
    [self.view addSubview:room];

    firstCG=CGRectMake(0, TopSeachHigh+151, fDeviceWidth, 50);
    stdCellVc *carRoom=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"carRoom" titleName:@"车库信息" txtName:@"" lookImg:@"rightArrow" sendid:3];
    [self.view addSubview:carRoom];

     firstCG=CGRectMake(0, TopSeachHigh+202, fDeviceWidth, 50);
    stdCellVc *carSeat=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"carSeat" titleName:@"车位信息" txtName:@"" lookImg:@"rightArrow" sendid:4];
    [self.view addSubview:carSeat];
    
    firstCG=CGRectMake(0, TopSeachHigh+272, fDeviceWidth, 50);
    stdCellVc *qianFee=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"fee" titleName:@"欠费信息" txtName:@"" lookImg:@"rightArrow" sendid:5];
    [self.view addSubview:qianFee];
    
    firstCG=CGRectMake(0, TopSeachHigh+342, fDeviceWidth, 50);
    stdCellVc *about=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"about" titleName:@"关于物业通" txtName:@"" lookImg:@"rightArrow" sendid:6];
    [self.view addSubview:about];


    personInfo.stdDelegate=self;
    room.stdDelegate=self;
    carRoom.stdDelegate=self;
    carSeat.stdDelegate=self;
    qianFee.stdDelegate=self;
    about.stdDelegate=self;
}
-(void)pushPersonVC{
    personInfoViewController *personVc=[[personInfoViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:NO];
}

-(void)pushHomeVC{
    HomeInfoViewController *personVc=[[HomeInfoViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:NO];
}

-(void)pushCarRoomVC{
    carRoomViewController *personVc=[[carRoomViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:NO];
}
-(void)pushCarSeatVC{
    carSeatViewController *personVc=[[carSeatViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:NO];
}
-(void)pushFeeNeedVC{
    feeNeedViewController *personVc=[[feeNeedViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:NO];
}
-(void)clickDelegate:(NSInteger)sendId{
    NSLog(@"%ld",(long)sendId);
    
    switch (sendId) {
        case 1://个人信息
            [self pushPersonVC];
            break;
        case 2://房屋信息
            [self pushHomeVC];
            break;
        case 3://车库信息
            [self pushCarRoomVC];
            break;
        case 4://车位信息
            [self pushCarSeatVC];
            break;
        case 5://欠费信息
            [self pushFeeNeedVC];
            break;
        case 6://关于
            
            break;
        default:
            break;
    }
}
@end
