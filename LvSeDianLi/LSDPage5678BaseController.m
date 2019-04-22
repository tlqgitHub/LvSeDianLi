//
//  LSDPage5678BaseController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//
//跑马灯
//[labelShow sizeToFit];
//CGRect frame = labelShow.frame;
//frame.origin.x = 320;
//labelShow.frame = frame;
//
//[UIView beginAnimations:@"testAnimation" context:NULL];
//[UIView setAnimationDuration:8.8f];
//[UIView setAnimationCurve:UIViewAnimationCurveLinear];
//[UIView setAnimationDelegate:self];
//[UIView setAnimationRepeatAutoreverses:NO];
//[UIView setAnimationRepeatCount:999999];
//
//frame = labelShow.frame;
//frame.origin.x = -frame.size.width;
//labelShow.frame = frame;
//[UIView commitAnimations];
#import "LSDHost.h"
#import "HTTPClient.h"
#import "XMLDictionary.h"

#import "LSDPage5678BaseController.h"

#import "LSDTitleViewCell.h"
#import "LSDStatusViewCell.h"

#import "LSDErrorViewController.h"
#import "LSDPage8DesViewController.h"
#import "NSDate+Addition.h"

#import "LSDPage5DefultCell.h"
#import "LSDPage6Cell.h"
#import "LSDPage7ViewCell.h"
#import "LSDPage8Cell.h"

#import "LSDChartViewCell.h"

@interface LSDPage5678BaseController ()
{
    NSInteger selectIndex;
    
    NSInteger subSelectIndex;
    NSArray *dataArr;
    NSDictionary *dataDic;
    
    __weak LSDPage5678BaseController* selfWeak;
}


@property (weak, nonatomic) IBOutlet UIButton *ib_tab0;
@property (weak, nonatomic) IBOutlet UIButton *ib_tab1;
@property (weak, nonatomic) IBOutlet UIButton *ib_tab2;
@property (weak, nonatomic) IBOutlet UIButton *ib_tab3;

@property (weak, nonatomic) IBOutlet UIView *ib_views;
@end

@implementation LSDPage5678BaseController

-(void)initView
{
        ViewBorderRadius(self.ib_tab0, 0, 1, RGBCOLOR(29, 131, 107));
        ViewBorderRadius(self.ib_tab1, 0, 1, RGBCOLOR(29, 131, 107));
        ViewBorderRadius(self.ib_tab2, 0, 1, RGBCOLOR(29, 131, 107));
        ViewBorderRadius(self.ib_tab3, 0, 1, RGBCOLOR(29, 131, 107));
    
    [self.ib_tab0 setTitle:LocalString(@"概况") forState:UIControlStateNormal];
    [self.ib_tab1 setTitle:LocalString(@"天气") forState:UIControlStateNormal];
    [self.ib_tab2 setTitle:LocalString(@"发电量") forState:UIControlStateNormal];
    [self.ib_tab3 setTitle:LocalString(@"逆变器") forState:UIControlStateNormal];
}

-(IBAction)selectBtnAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    if (selectIndex==button.tag) {
        return;
    }
    selectIndex = button.tag;
    
    [self defultselectBtnAction:selectIndex];
}

-(void)defultselectBtnAction:(NSInteger)index
{
    for (UIView *view in self.ib_views.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)view;
            if (button.tag == selectIndex) {
                [button setBackgroundImage:[UIImage imageNamed:@"bg_bar_selected.png"] forState:UIControlStateNormal];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"bg_tab_noSeclected.png"] forState:UIControlStateNormal];
            }
        }
    }

    //自动刷新
    [self.mTableView headerBeginRefreshing];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LocalString(@"p1_app_name")];
    
    selfWeak = self;
    
    [self initView];
    
    selectIndex = 0;
    subSelectIndex = 0;
    
    self.mTableView.footerHidden = YES;
    
    [self defultselectBtnAction:selectIndex];
}

- (void)fRefresh
{
    [self initData];
}

- (void)initData
{
    NSDictionary *pram = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID],@"psId":[NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]]};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetPsDetailByUser];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        
        dataDic = data;
        [self initSwitch];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

- (void)initSwitch
{
    switch (selectIndex) {
        case 0:
            [self initData0];
            break;
        case 1:
            [self initData1];
            break;
        case 2:
        {
            switch (subSelectIndex) {
                case 0:
                    [self initData20];
                    break;
                case 1:
                    [self initData21];
                    break;
                case 2:
                    [self initData22];
                    break;
                    
                default:
                    [self initData20];
                    break;
            }
        }

            break;
        case 3:
            [self initData3];
            break;
            
        default:
            [self initData0];
            break;
    }
}

- (void)initData0
{
    dataArr = @[@{@"title":LocalString(@"装机容量"), @"value":[dataDic stringForKey:@"Capacity"]},
                @{@"title":LocalString(@"功率"), @"value":[dataDic stringForKey:@"pac"]},
                @{@"title":LocalString(@"单位发电量"), @"value":[dataDic stringForKey:@"unitPac"]},
                @{@"title":LocalString(@"今日发电量"), @"value":[dataDic stringForKey:@"pac_today"]},
                @{@"title":LocalString(@"今日收益"), @"value":[dataDic stringForKey:@"profit_today"]},
                @{@"title":LocalString(@"昨日发电量"), @"value":[dataDic stringForKey:@"pac_yesterday"]},
                @{@"title":LocalString(@"累计发电量"), @"value":[dataDic stringForKey:@"pac_total"]},
                @{@"title":LocalString(@"累计收益"), @"value":[dataDic stringForKey:@"profit_total"]}                    ];
    
    [self.mTableView headerEndRefreshing];
    [self.mTableView reloadData];
}

- (void)initData1
{
    NSDictionary *pram = @{@"psId":[NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]]};
    
    [[HTTPClient sharedClient] GET:[NSString stringWithFormat:@"%@%@",[[LSDHost sharedClient] getHost], @"IosService.asmx/GetNewWeather"]
                        parameters:pram
                        success:^(NSURLSessionDataTask *task, id responseObject)
    {
        
        if (task.error) {
            return ;
        }
        
        NSDictionary * object = [NSDictionary dictionaryWithXMLParser:responseObject];
        
        DLog(@"responseObject : %@",object);
        
//        if ([[object stringForKey:@"from"] isEqualToString:@"0"])//本地
//        {
//            //            *风速（新增）
//            //            *湿度（新增）
//            //            *数据来源(新增) ：
//            //            显示为：Local，或绑定气象站名称，或Yaohoo。
//            
//            dataArr = @[@{@"title":LocalString(@"日照"),
//                          @"image":@"page6_sunshine",
//                          @"value":[NSString stringWithFormat:@"%@w/m²", [object stringForKey:@"Irr"]]},
//                        @{@"title":LocalString(@"环境温度"),//Sur_tem
//                          @"image":@"page6_littlesun",
//                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Sur_tem"]]},
//                        @{@"title":LocalString(@"背板温度"),
//                          @"image":@"page6_banwen",
//                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Battery_tem"]]},
//                        @{@"title":LocalString(@"峰值日照时数"),
//                          @"image":@"page6_sunhours",
//                          @"value":[NSString stringWithFormat:@"%@h", [object stringForKey:@"DayIrr"]]},
//                        @{@"title":LocalString(@"风速"),
//                          @"image":@"page6_wind",
//                          @"value":[NSString stringWithFormat:@"%@m/s", [object stringForKey:@"Windspeed"]]},
//                        @{@"title":LocalString(@"湿度"),
//                          @"image":@"page6_wet",
//                          @"value":[NSString stringWithFormat:@"%@%%", [object stringForKey:@"humidity"]]},
//                        @{@"title":LocalString(@"数据来源"),
//                          @"image":@"page6_sjly",
//                          @"value":LocalString(@"本地")}
//                        ];
//            
//        }else if ([[object stringForKey:@"from"] isEqualToString:@"weather"])//绑定
//        {
//            dataArr = @[@{@"title":LocalString(@"日照"),
//                          @"image":@"page6_sunshine",
//                          @"value":[NSString stringWithFormat:@"%@w/m²", [object stringForKey:@"Irr"]]},
//                        @{@"title":LocalString(@"环境温度"),//Sur_tem
//                          @"image":@"page6_littlesun",
//                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Sur_tem"]]},
//                        @{@"title":LocalString(@"背板温度"),
//                          @"image":@"page6_banwen",
//                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Battery_tem"]]},
//                        @{@"title":LocalString(@"峰值日照时数"),
//                          @"image":@"page6_sunhours",
//                          @"value":[NSString stringWithFormat:@"%@h", [object stringForKey:@"DayIrr"]]},
//                        @{@"title":LocalString(@"风速"),
//                          @"image":@"page6_wind",
//                          @"value":[NSString stringWithFormat:@"%@m/s", [object stringForKey:@"Windspeed"]]},
//                        @{@"title":LocalString(@"湿度"),
//                          @"image":@"page6_wet",
//                          @"value":[NSString stringWithFormat:@"%@%%", [object stringForKey:@"humidity"]]},
//                        @{@"title":LocalString(@"数据来源"),
//                          @"image":@"page6_sjly",
//                          @"value":[self.param stringForKey:@"Name"]}
//                        ];
//            
//        }else
        
        if ([[object stringForKey:@"from"] isEqualToString:@"Yahoo"]) //雅虎
        {
            dataArr = @[@{@"title":LocalString(@"温度"),
                          @"image":@"page6_littlesun",
                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Sur_tem"]]},
                        @{@"title":LocalString(@"风速"),
                          @"image":@"page6_wind",
                          @"value":[NSString stringWithFormat:@"%@m/s", [object stringForKey:@"Windspeed"]]},
                        @{@"title":LocalString(@"湿度"),
                          @"image":@"page6_wet",
                          @"value":[NSString stringWithFormat:@"%@%%", [object stringForKey:@"humidity"]]},
                        @{@"title":LocalString(@"数据来源"),
                          @"image":@"page6_sjly",
                          @"value":LocalString(@"雅虎")}
                        ];
            
        }else{
            
            dataArr = @[@{@"title":LocalString(@"日照"),
                          @"image":@"page6_sunshine",
                          @"value":[NSString stringWithFormat:@"%@w/m²", [object stringForKey:@"Irr"]]},
                        @{@"title":LocalString(@"环境温度"),//Sur_tem
                          @"image":@"page6_littlesun",
                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Sur_tem"]]},
                        @{@"title":LocalString(@"背板温度"),
                          @"image":@"page6_banwen",
                          @"value":[NSString stringWithFormat:@"%@℃", [object stringForKey:@"Battery_tem"]]},
                        @{@"title":LocalString(@"峰值日照时数"),
                          @"image":@"page6_sunhours",
                          @"value":[NSString stringWithFormat:@"%@h", [object stringForKey:@"DayIrr"]]},
                        @{@"title":LocalString(@"风速"),
                          @"image":@"page6_wind",
                          @"value":[NSString stringWithFormat:@"%@m/s", [object stringForKey:@"Windspeed"]]},
                        @{@"title":LocalString(@"湿度"),
                          @"image":@"page6_wet",
                          @"value":[NSString stringWithFormat:@"%@%%", [object stringForKey:@"humidity"]]},
                        @{@"title":LocalString(@"数据来源"),
                          @"image":@"page6_sjly",
                          @"value":LocalString([object stringForKey:@"from"])}
                        ];

        }
        
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
        
    }
                           failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        [self showTextErrorDialog0:@"network or server error!"];
        [self.mTableView headerEndRefreshing];
        //        [self.mTableView reloadData];
    }];
}

//- (void)initData11
//{
//    NSDictionary *pram = @{@"psId":[NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]]};
//    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetWeather];
//    
//    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
//        
//        dataArr = @[@{@"title":LocalString(@"温度"),
//                      @"image":@"page6_littlesun",
//                      @"value":[NSString stringWithFormat:@"%@℃", [data stringForKey:@"Celsius"]]},
//                    @{@"title":LocalString(@"风速"),
//                      @"image":@"page6_wind",
//                      @"value":[NSString stringWithFormat:@"%@m/s", [data stringForKey:@"Speed"]]},
//                    @{@"title":LocalString(@"湿度"),
//                      @"image":@"page6_wet",
//                      @"value":[NSString stringWithFormat:@"%@%%", [data stringForKey:@"Humidity"]]}
////                    ,
////                    @{@"title":LocalString(@"能见度"),
////                      @"image":@"page6_sight",
////                      @"value":[NSString stringWithFormat:@"%@m", [data stringForKey:@"Visibility"]]}
//                    ];
//        
//        [self.mTableView headerEndRefreshing];
//        [self.mTableView reloadData];
//    } errorHandler:^(NSString *errMsg) {
//        [self.mTableView headerEndRefreshing];
//    }];
//    
//    [self.mTableView headerEndRefreshing];
//    [self.mTableView reloadData];
//}

-(void)Page7SeelectIndex:(NSInteger)sindex
{
    if (subSelectIndex==sindex) {
        return;
    }
    
    subSelectIndex = sindex;
    
    switch (subSelectIndex) {
        case 0:
            [self initData20];
            break;
        case 1:
            [self initData21];
            break;
        case 2:
            [self initData22];
            break;
        default:
            [self initData20];
            break;
    }
}

- (void)initData20
{
    NSDictionary* pram = @{ @"date" : [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"],
                            @"psId" : [NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]] };
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetGroupedDayPac];
    
    [self httpGetUrl:urlStr
            WithData:pram
   completionHandler:^(NSDictionary* data) {
       
       self->dataArr = [self isNoArr:data key:@"DayPacInfo"];
//       dataArr = [data arrayForKey:@"QueryResultInfo"];
//       if(!dataArr){
//           dataArr = @[[data dictionaryForKey:@"QueryResultInfo"]];
//       }
       [self.mTableView headerEndRefreshing];
       [self.mTableView reloadData];
   }
        errorHandler:^(NSString* errMsg) {
            [self.mTableView headerEndRefreshing];
        }];
}

- (void)initData21
{
    NSDictionary* pram = @{ @"userId" : [USER_DEFAULT stringForKey:KEY_USERID],
                            @"date" : [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"],
                            @"psId" : [NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]] };
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetPsMonthPac];
    
    [self httpGetUrl:urlStr
            WithData:pram
   completionHandler:^(NSDictionary* data) {
       
       self->dataArr = [self isNoArr:data key:@"QueryResultInfo"];
//       dataArr = [data arrayForKey:@"QueryResultInfo"];
//       if(!dataArr){
//           dataArr = @[[data dictionaryForKey:@"QueryResultInfo"]];
//       }
       [self.mTableView headerEndRefreshing];
       [self.mTableView reloadData];
   }
        errorHandler:^(NSString* errMsg) {
            [self.mTableView headerEndRefreshing];
        }];
}

- (void)initData22
{
    NSDictionary* pram = @{ @"userId" : [USER_DEFAULT stringForKey:KEY_USERID],
                            @"date" : [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"],
                            @"psId" : [NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]] };
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetPsYearPac];
    
    [self httpGetUrl:urlStr
            WithData:pram
   completionHandler:^(NSDictionary* data) {
       
       self->dataArr = [self isNoArr:data key:@"QueryResultInfo"];
//       dataArr = [data arrayForKey:@"QueryResultInfo"];
//       if(!dataArr){
//           dataArr = @[[data dictionaryForKey:@"QueryResultInfo"]];
//       }
       [self.mTableView headerEndRefreshing];
       [self.mTableView reloadData];
   }
        errorHandler:^(NSString* errMsg) {
            [self.mTableView headerEndRefreshing];
        }];
}

- (void)initData3
{
    NSDictionary* pram = @{ @"userId" : [USER_DEFAULT stringForKey:KEY_USERID],
                            @"psId" : [NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]] };
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetInverterDeviceByUser];
    
    [self httpGetUrl:urlStr
            WithData:pram
   completionHandler:^(NSDictionary* data) {
       
       dataArr = [self isNoArr:data key:@"InverterInfo"];
//       dataArr = [data arrayForKey:@"InverterInfo"];
//       if(!dataArr){
//           dataArr = @[[data dictionaryForKey:@"InverterInfo"]];
//       }
       
       //排序
       // 利用block进行排序
       
       if(dataArr.count>1)
       {
           dataArr = [dataArr sortedArrayUsingComparator:
                      ^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                          // 先按照姓排序
                          NSComparisonResult result = [[NSNumber numberWithFloat:[self getValue:[obj1 stringForKey:@"totalpac"]]] compare:[NSNumber numberWithFloat:[self getValue:[obj2 stringForKey:@"totalpac"]]]];
                          // 如果有相同的姓，就比较名字
                          if (result == NSOrderedSame) {
                              result = NSOrderedAscending;
                          }
                          
                          return result;
                      }];
       }
       
       [self.mTableView headerEndRefreshing];
       [self.mTableView reloadData];
   }
        errorHandler:^(NSString* errMsg) {
            [self.mTableView headerEndRefreshing];
        }];
}

-(CGFloat)getValue:(NSString*)value
{
    CGFloat tmd = [[value substringToIndex:value.length-4] floatValue];
    
    if ([value rangeOfString:@"kWh"].location != NSNotFound)
    {
        tmd = tmd*1.0;
    }else if ([value rangeOfString:@"MWh"].location != NSNotFound)
    {
        tmd = tmd*1000.0;
    }else if ([value rangeOfString:@"GWh"].location != NSNotFound)
    {
        tmd = tmd*1000000.0;
    }
    
    return tmd;
    
    return 0.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (selectIndex) {
        case 0:
            return 10;
            break;
        case 1:
            return dataArr?dataArr.count+2:2;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return dataArr?dataArr.count+2:2;
            break;
    }
    
    return 0;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row==0)
    {
        return 60;
    }else if(indexPath.row==1)
    {
        return 40;
    }else{
        switch (selectIndex)
        {
            case 0:
                return 44;
                break;
            case 1:
                return 46;
                break;
            case 2:
                return 460;
                break;
            case 3:
                return 44;

                break;
        }
    }
    return 0;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row==0) {
        static NSString * CustomTableViewIdentifier =@"LSDTitleViewCell";
        
        LSDTitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }
        
        [cell setData:dataDic];
        return cell;
    }else if(indexPath.row==1) {
        
        if (selectIndex==2) {
            static NSString * CustomTableViewIdentifier =@"LSDPage7ViewCell";
            
            LSDPage7ViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                      owner:self
                                                    options:nil] firstObject];
            }
            
            [cell setDefultIndex:subSelectIndex
                            show:dataArr
                           block:^(NSInteger sIndex) {
                [selfWeak Page7SeelectIndex:sIndex];
            }];
            
            return cell;
        }
        
        static NSString * CustomTableViewIdentifier =@"LSDStatusViewCell";
        
        LSDStatusViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }
        
        if (selectIndex==0)
        {
            [cell setData:dataDic];
            
            cell.ib_textLeft.text = LocalString(@"运行状态");
            
            cell.showPSDError = ^(NSInteger psId){
                
                [self.navigationController pushViewController:[[LSDErrorViewController alloc]initWithParmsDic:@{@"PsId":[self.param stringForKey:@"PsId"]}] animated:YES];
            };
            
        }else if(selectIndex ==1)
        {
            cell.ib_textLeft.text = [dataDic stringForKey:@"City"];
            cell.ib_textCenter.hidden = YES;
            cell.ib_textRight.hidden = YES;
            cell.ib_img_icon.hidden = NO;
            
            [cell.ib_img_icon setImage:[self imageWithWeather:[dataDic stringForKey:@"weather"]]];
        }else if(selectIndex == 3)
        {
            cell.ib_textLeft.text = LocalString(@"逆变器1");
//            cell.ib_textCenter.text = LocalString(@"发电量(kWh)");
            cell.ib_textCenter.hidden = YES;
            cell.ib_textRight.text = LocalString(@"日发电量");
            cell.ib_img_icon.hidden = YES;
        }

        return cell;
        
    }else{
        if (selectIndex==0) {
            static NSString * CustomTableViewIdentifier =@"LSDPage5DefultCell";
            
            LSDPage5DefultCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                      owner:self
                                                    options:nil] firstObject];
            }
            
            [cell setData:[dataArr objectAtIndex:indexPath.row-2]];
            
            if(indexPath.row==3){
                cell.ib_textValue.textColor = [UIColor colorWithRed:173/255.0 green:81/255.0 blue:10/255.0 alpha:1.0];//173  81 10
            }
            
            if(indexPath.row==5){
                cell.ib_textValue.textColor = [UIColor colorWithRed:173/255.0 green:81/255.0 blue:10/255.0 alpha:1.0];//173  81 10
            }
            
            if(indexPath.row==7){
                cell.ib_textValue.textColor = [UIColor colorWithRed:173/255.0 green:81/255.0 blue:10/255.0 alpha:1.0];//173  81 10
            }
            
            return cell;
        }else if(selectIndex==1){
            static NSString* CustomTableViewIdentifier = @"LSDPage6Cell";
            
            LSDPage6Cell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                      owner:self
                                                    options:nil] firstObject];
            }
            
            [cell setData:[dataArr objectAtIndex:indexPath.row - 2]];
            
            return cell;
        }else if(selectIndex==2)
        {
            static NSString* CustomTableViewIdentifier = @"LSDChartViewCell";
            
            LSDChartViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                      owner:self
                                                    options:nil] firstObject];
            }
            
            switch (subSelectIndex) {
                case 0:
//                    [cell setLineData:dataArr];
                    [cell setNewLineWithData:dataArr];
                    break;
                case 1:
                    [cell setBarData:dataArr];
                    break;
                case 2:
                    [cell setBarYearData:dataArr];
                    break;
            }
            
            cell.showInfo = ^(NSInteger infoIndex){
//                [self showTextInfoDialog:[NSString stringWithFormat:@"%@        %@", [[dataArr objectAtIndex:infoIndex] stringForKey:@"date"], [[dataArr objectAtIndex:infoIndex] stringForKey:@"Text"]]];
            };
           
            return cell;
            
        }else if(selectIndex==3)
        {
            static NSString* CustomTableViewIdentifier = @"LSDPage8Cell";
            
            LSDPage8Cell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                      owner:self
                                                    options:nil] firstObject];
            }
            
            CGFloat maxF = 0.0;
            
            for (NSDictionary *dic in dataArr)
            {
                NSString *totalpac = [dic stringForKey:@"totalpac"];
                CGFloat tmpF = [[totalpac substringToIndex:totalpac.length-5] floatValue];
                maxF = maxF>tmpF?maxF:tmpF;
            }
            
            [cell setData:[dataArr objectAtIndex:indexPath.row - 2] max:maxF];
            
            return cell;

        }
    }
    
    return nil;
}

#pragma mark Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex!=3) {
        return;
    }
    if (indexPath.row>1) {
        [self.navigationController pushViewController:[[LSDPage8DesViewController alloc] initWithParmsDic:[dataArr objectAtIndex:indexPath.row - 2]] animated:YES];
    }
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
    }else if([weather rangeOfString:@"Breezy"].location!=NSNotFound)
    {
        weatherStr = @"page6_yin.png";
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
