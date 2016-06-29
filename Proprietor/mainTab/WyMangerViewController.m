//
//  WyMangerViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/13.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "WyMangerViewController.h"
#import "AppDelegate.h"
#import "PublicDefine.h"
#import "repairViewController.h"
#import "complainViewController.h"
#import "noticeViewController.h"
#import "contactUsViewController.h"
@interface WyMangerViewController ()
{
   
    repairViewController *repairVc;
    complainViewController *complainVc;
    noticeViewController *noticeVc;
    contactUsViewController *contactVc;
    UIViewController *currVc;
}
@end

@implementation WyMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawSegmentedView];
   
    
    
    [self loadAllTableView];
    // Do any additional setup after loading the view.
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"物业管理";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    [self.view addSubview:TopView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"assortment_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"assortment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"物业管理";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)drawSegmentedView{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"物业报修",@"物业投诉",@"物业公告",@"联系物业",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    CGFloat sgWidth=fDeviceWidth-40;
    segmentedControl.frame = CGRectMake(20,TopSeachHigh+10,sgWidth,30);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = topSearchBgdColor;
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    if ((currVc==repairVc &&Index==0)||(currVc==complainVc &&Index==1)||(currVc==noticeVc &&Index==2) ||(currVc==contactVc &&Index==3)){
        return;
    }
    switch (Index) {
        case 0:
            [self replaceController:currVc newController:repairVc];
            break;
        case 1:
            [self replaceController:currVc newController:complainVc];
            break;
        case 2:
            [self replaceController:currVc newController:noticeVc];
            break;
        case 3:
            [self replaceController:currVc newController:contactVc];
            break;
        default:
            break;
    }
}
-(void)loadAllTableView{
    repairVc=[[repairViewController alloc]init];
    [self addChildViewController:repairVc];
    float topHight=TopSeachHigh+50;
    
    [repairVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight)];
    
    complainVc=[[complainViewController alloc]init];
    [self addChildViewController:complainVc];
    [complainVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight)];
    
    noticeVc=[[noticeViewController alloc]init];
    [self addChildViewController:noticeVc];
    [noticeVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight)];
    
    contactVc=[[contactUsViewController alloc]init];
    [self addChildViewController:contactVc];
    [contactVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight)];
    
    [self.view addSubview:repairVc.view];
    currVc=repairVc;
}


- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            currVc = newController;
            
        }else{
            
            currVc = oldController;
            
        }
    }];
}

@end
