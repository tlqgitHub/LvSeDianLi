//
//  LSDPageTabViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPageTabViewController.h"

#import "LSDPage5678BaseController.h"

@interface LSDPageTabViewController ()

@end

@implementation LSDPageTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


//    [self setTitle:LocalString(@"绿色电力网")];
    
//    NSArray *items = self.tabBar.items;
//    
//    UITabBarItem *homeItem = items[0];
//    homeItem.title = nil;
//    homeItem.image = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    homeItem.selectedImage = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *proItem = items[1];
//    proItem.title = nil;
//    proItem.image = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    proItem.selectedImage = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *perItem = items[2];
//    perItem.title = nil;
//    perItem.image = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    perItem.selectedImage = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *moreItem = items[3];
//    moreItem.title = nil;
//    moreItem.image = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    moreItem.selectedImage = [[UIImage imageNamed:@"page5_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    CGFloat offset = 5.0;
//    for (UITabBarItem *item in self.tabBar.items) {
//        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    }
    
    //    默认UITabBarController的tabBar背景是黑色的。可以按 下面方法：
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:48/255.0 green:168/255.0 blue:145/255.0 alpha:1.0];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;

    [[[self viewControllers] objectAtIndex:0] setValue:self.param forKey:@"param"];
    [[[self viewControllers] objectAtIndex:1] setValue:self.param forKey:@"param"];
    [[[self viewControllers] objectAtIndex:2] setValue:self.param forKey:@"param"];
    [[[self viewControllers] objectAtIndex:3] setValue:self.param forKey:@"param"];
//    [((LSDPage5678BaseController*)((UINavigationController*)[[self viewControllers] objectAtIndex:0]))setParam:self.param];
//    [((LSDPage5678BaseController*)((UINavigationController*)[[self viewControllers] objectAtIndex:1]))setParam:self.param];
//    [((LSDPage5678BaseController*)((UINavigationController*)[[self viewControllers] objectAtIndex:2]))setParam:self.param];
//    [((LSDPage5678BaseController*)((UINavigationController*)[[self viewControllers] objectAtIndex:3]))setParam:self.param];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
