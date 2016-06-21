//
//  StdRootController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "StdRootController.h"
#import "PublicDefine.h"
#import "HomeViewController.h"
#import "WyMangerViewController.h"
#import "ShopViewController.h"
#import "MyInfoViewController.h"


@implementation StdRootController
-(void)SetUpStdRootView:(UITabBarController *)rootTab
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.view.backgroundColor = MyGrayColor;
    
    WyMangerViewController *wyViewController = [[WyMangerViewController alloc]init];
    wyViewController.view.backgroundColor = MyGrayColor;
    
    ShopViewController *shopViewController = [[ShopViewController alloc]init];
    shopViewController.view.backgroundColor = MyGrayColor;
    
    MyInfoViewController *myInfoViewController = [[MyInfoViewController alloc]init];
    myInfoViewController.view.backgroundColor = MyGrayColor;
    
  
    
    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UINavigationController *wymanger = [[UINavigationController alloc] initWithRootViewController:wyViewController];
    
    UINavigationController *shop = [[UINavigationController alloc] initWithRootViewController:shopViewController];
    
    UINavigationController *myinfo = [[UINavigationController alloc] initWithRootViewController:myInfoViewController];

    rootTab.viewControllers = [NSArray arrayWithObjects:home, wymanger,shop,myinfo, nil];
    
    rootTab.tabBar.frame=CGRectMake(0, fDeviceHeight-MainTabbarHeight, fDeviceWidth, MainTabbarHeight);
    
    
    for (UINavigationController *stack in rootTab.viewControllers) {
        [self setupNavigationBar:stack];
    }
   
    
    rootTab.tabBar.barStyle=UIBarStyleDefault;
    rootTab.tabBar.translucent=false;
    rootTab.tabBar.tintColor=tabTxtColor;
   
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"123123");
//    int index = viewController.selectedIndex;
//    NSString *titleName = nil;
//    switch (index) {
//        case 0:
//            titleName = @"FirstView";
//            break;
//        case 1:
//            titleName = @"SecondView";
//            break;
//        case 2:
//            titleName = @"ThirdView";
//            break;
//            
//        default:
//            break;
//    }
}

- (void)setupNavigationBar:(UINavigationController *)stack{
    UIImage *barImage = [UIImage imageNamed:@"redtop.png"];
    if(IOS7_OR_LATER)
        [stack.navigationBar setBackgroundImage:barImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    else
        [stack.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
}
@end
