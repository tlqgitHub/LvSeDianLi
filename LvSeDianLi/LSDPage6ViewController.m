//
//  LSDPage6ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage6ViewController.h"

#import "LSDStatusViewCell.h"
#import "LSDPage6Cell.h"

@interface LSDPage6ViewController ()
{
    NSArray *dataArr;
}

@end

@implementation LSDPage6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//
- (void)initData0
{
    NSDictionary *pram = @{@"psId":[NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]]};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetEnvironmentDetail];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
    
        if ([data stringForKey:@"Sur_tem"].length<1) {
            [self initData1];
            return;
        }
        
        dataArr = @[@{@"title":LocalString(@"日照"),
                      @"image":@"page6_sunshine",
                      @"value":[NSString stringWithFormat:@"%@'w/m²", [data stringForKey:@"Irr"]]},
                    @{@"title":LocalString(@"环境温度"),
                      @"image":@"page6_littlesun",
                      @"value":[NSString stringWithFormat:@"%@℃", [data stringForKey:@"Sur_tem"]]},
                    @{@"title":LocalString(@"背板温度"),
                      @"image":@"page6_banwen",
                      @"value":[NSString stringWithFormat:@"%@℃", [data stringForKey:@"Battery_tem"]]},
                    @{@"title":LocalString(@"峰值日照时数"),
                      @"image":@"page6_sunhours",
                      @"value":[NSString stringWithFormat:@"%@h", [data stringForKey:@"DayIrr"]]}
                    ];
                    
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
    
    [self.mTableView headerEndRefreshing];
    [self.mTableView reloadData];
}

- (void)initData1
{
    NSDictionary *pram = @{@"psId":[NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]]};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetWeather];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        
        dataArr = @[@{@"title":LocalString(@"温度"),
                      @"image":@"page6_littlesun",
                      @"value":[NSString stringWithFormat:@"%@℃", [data stringForKey:@"Celsius"]]},
                    @{@"title":LocalString(@"风速"),
                      @"image":@"page6_wind",
                      @"value":[NSString stringWithFormat:@"%@m/s", [data stringForKey:@"Speed"]]},
                    @{@"title":LocalString(@"湿度"),
                      @"image":@"page6_wet",
                      @"value":[NSString stringWithFormat:@"%@%%", [data stringForKey:@"Humidity"]]},
                    @{@"title":LocalString(@"能见度"),
                      @"image":@"page6_sight",
                      @"value":[NSString stringWithFormat:@"%@m", [data stringForKey:@"Visibility"]]}
                    ];
        
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
    
    [self.mTableView headerEndRefreshing];
    [self.mTableView reloadData];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }else if(indexPath.row==1) {
        return 40;
    }else{
        return 46;
    }
}

//5.	功率和今日发电量取橙色
/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
//    if (indexPath.row == 1) {
//        static NSString* CustomTableViewIdentifier = @"LSDStatusViewCell";
//        
//        LSDStatusViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
//                                                  owner:self
//                                                options:nil] firstObject];
//        }
//        
//        cell.ib_textLeft.text = [self.dataDic stringForKey:@"City"];
//        cell.ib_textCenter.hidden = YES;
//        cell.ib_textRight.hidden = YES;
//        cell.ib_img_icon.hidden = NO;
//        
//        [cell.ib_img_icon setImage:[self imageWithWeather:[self.dataDic stringForKey:@"weather"]]];
//
//        return cell;
//    }
//    else if (indexPath.row > 1) {
//        static NSString* CustomTableViewIdentifier = @"LSDPage6Cell";
//        
//        LSDPage6Cell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
//                                                  owner:self
//                                                options:nil] firstObject];
//        }
//        
//        [cell setData:[dataArr objectAtIndex:indexPath.row - 2]];
//        
//        return cell;
//    }
//    else {
//        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//    }
//
    return nil;
}

//晴天，阴天，雨天，雪天。
-(UIImage*)imageWithWeather:(NSString*)weather
{

    NSString *weatherStr = @"";
    
    if([weather rangeOfString:@"Snow"].location!=NSNotFound)
    {
        weatherStr = @"page6_xue.png";
    }else if([weather rangeOfString:@"Cloudy"].location!=NSNotFound)
    {
        weatherStr = @"page6_yin.png";
    }else if([weather rangeOfString:@"Rain"].location!=NSNotFound)
    {
        weatherStr = @"page6_yu.png";
    }else{
        weatherStr = @"page6_qing.png";
    }
    
    return [UIImage imageNamed:weatherStr];
}

- (void)didReceiveMemoryWarning {
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
