//
//  LSDChartViewCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDChartViewCell.h"
#import "NSDictionary+SafeAccess.h"

#import "ACMacros.h"

#import "SHLineGraphView.h"
#import "SHPlot.h"

@implementation LSDChartViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setNewLineWithData:(NSArray*)newArr
{
    self.tmpArr = newArr;
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText0:self.tmpArr[self.tmpArr.count-1]];
    }
    
    ViewRadius(self.ib_lbViews, 3);
    
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat maxValue = 0.00;
    
    NSMutableArray *nArr = [NSMutableArray new];
    
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];
    
    for (NSInteger i = 1; i<=newArr.count; i++) {
        
        NSDictionary *tmpDic = [newArr objectAtIndex:i-1];
        [xLableArr addObject: @{[NSNumber numberWithInteger:i]: [tmpDic stringForKey:@"time"] }];
        [yLableArr addObject: @{[NSNumber numberWithInteger:i]: [NSString stringWithFormat:@" %@", [tmpDic stringForKey:@"pac_value"]] }];
        [nArr addObject:[NSNumber numberWithInteger:i]];
        
        maxValue = [[tmpDic stringForKey:@"pac_value"] floatValue]>maxValue?[[tmpDic stringForKey:@"pac_value"] floatValue]:maxValue;
    }
    
    NSInteger w = 30;
    //initate the graph view
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0, w*xLableArr.count>App_Frame_Width?w*xLableArr.count:App_Frame_Width, self.ib_sv.frame.size.height)];
    
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor whiteColor],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor whiteColor],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kPlotBackgroundLineColorKye : [UIColor whiteColor]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = @(maxValue+0.01);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @" ";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
//    _lineGraph.xAxisValues = @[
//                               @{ @1 : @"JAN" },
//                               @{ @2 : @"FEB" },
//                               @{ @3 : @"MAR" },
//                               @{ @4 : @"APR" },
//                               @{ @5 : @"MAY" },
//                               @{ @6 : @"JUN" },
//                               @{ @7 : @"JUL" },
//                               @{ @8 : @"AUG" },
//                               @{ @9 : @"SEP" },
//                               @{ @10 : @"OCT" },
//                               @{ @11 : @"NOV" },
//                               @{ @12 : @"DEC" }
//                               ];
    _lineGraph.xAxisValues = xLableArr;
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
//    _plot1.plottingValues = @[
//                              @{ @1 : @65.8 },
//                              @{ @2 : @20 },
//                              @{ @3 : @23 },
//                              @{ @4 : @22 },
//                              @{ @5 : @12.3 },
//                              @{ @6 : @45.8 },
//                              @{ @7 : @56 },
//                              @{ @8 : @97 },
//                              @{ @9 : @65 },
//                              @{ @10 : @10 },
//                              @{ @11 : @67 },
//                              @{ @12 : @23 }
//                              ];
    _plot1.plottingValues = yLableArr;
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
//    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
//    _plot1.plottingPointsLabels = arr;
    _plot1.plottingPointsLabels = nArr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:241/255.0 green:192/255.0 blue:148/255.0 alpha:0.9],
                                           kPlotStrokeWidthKey : @0,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor clearColor],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
//    [self.view addSubview:_lineGraph];
    [self.ib_sv addSubview:_lineGraph];
    self.ib_sv.contentSize = CGSizeMake(_lineGraph.frame.size.width, self.ib_sv.frame.size.height);
}

-(void)setNewLineWithData1:(NSArray*)newArr
{
    self.tmpArr = newArr;
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText2:self.tmpArr[self.tmpArr.count-1]];
    }
    
    ViewRadius(self.ib_lbViews, 3);
    
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat maxValue = 0.00;
    
    NSMutableArray *nArr = [NSMutableArray new];
    
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];

    for (NSInteger i = 1; i<=newArr.count; i++) {
        
        NSDictionary *tmpDic = [newArr objectAtIndex:i-1];
        [xLableArr addObject: @{[NSNumber numberWithInteger:i]: [tmpDic stringForKey:@"time"] }];
        [yLableArr addObject: @{[NSNumber numberWithInteger:i]: [NSString stringWithFormat:@" %@", [tmpDic stringForKey:@"inverter_value"]] }];
        [nArr addObject:[NSNumber numberWithInteger:i]];
        
        maxValue = [[tmpDic stringForKey:@"inverter_value"] floatValue]>maxValue?[[tmpDic stringForKey:@"inverter_value"] floatValue]:maxValue;
    }
    
    NSInteger w = 30;
    //initate the graph view
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0, w*xLableArr.count>App_Frame_Width?w*xLableArr.count:App_Frame_Width, self.ib_sv.frame.size.height)];

    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor whiteColor],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor whiteColor],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kPlotBackgroundLineColorKye : [UIColor whiteColor]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = @(maxValue+0.01);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @" ";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    //    _lineGraph.xAxisValues = @[
    //                               @{ @1 : @"JAN" },
    //                               @{ @2 : @"FEB" },
    //                               @{ @3 : @"MAR" },
    //                               @{ @4 : @"APR" },
    //                               @{ @5 : @"MAY" },
    //                               @{ @6 : @"JUN" },
    //                               @{ @7 : @"JUL" },
    //                               @{ @8 : @"AUG" },
    //                               @{ @9 : @"SEP" },
    //                               @{ @10 : @"OCT" },
    //                               @{ @11 : @"NOV" },
    //                               @{ @12 : @"DEC" }
    //                               ];
    _lineGraph.xAxisValues = xLableArr;
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    //    _plot1.plottingValues = @[
    //                              @{ @1 : @65.8 },
    //                              @{ @2 : @20 },
    //                              @{ @3 : @23 },
    //                              @{ @4 : @22 },
    //                              @{ @5 : @12.3 },
    //                              @{ @6 : @45.8 },
    //                              @{ @7 : @56 },
    //                              @{ @8 : @97 },
    //                              @{ @9 : @65 },
    //                              @{ @10 : @10 },
    //                              @{ @11 : @67 },
    //                              @{ @12 : @23 }
    //                              ];
    _plot1.plottingValues = yLableArr;
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
//    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    //    _plot1.plottingPointsLabels = arr;
    _plot1.plottingPointsLabels = nArr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:241/255.0 green:192/255.0 blue:148/255.0 alpha:0.9],
                                           kPlotStrokeWidthKey : @0,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor clearColor],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    //    [self.view addSubview:_lineGraph];
    [self.ib_sv addSubview:_lineGraph];
    self.ib_sv.contentSize = CGSizeMake(_lineGraph.frame.size.width, self.ib_sv.frame.size.height);
}

-(void)setLineData:(NSArray*)dataArr
{
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    
    self.ib_lableText.text = @"(kW)";
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];
//    
//    NSMutableArray *xShowLableArr = [NSMutableArray new];
//    NSMutableArray *yShowLableArr = [NSMutableArray new];
    
    NSInteger i = 0;
    
    NSInteger k = 1;
    
    if (dataArr.count>=36) {
        k=3;
    }else if(dataArr.count >=24)
    {
        k=2;
    }else if(dataArr.count >=12)
    {
        k=1;
    }else{
        k = 1;
    }
    
    for (NSDictionary *tmpDic in dataArr) {
//        [xShowLableArr addObject:[tmpDic stringForKey:@"date"]];
//        [yShowLableArr addObject:[tmpDic stringForKey:@"value"]];
        
        if (i%k==0) {
//            [xLableArr addObject:[[tmpDic stringForKey:@"time"] componentsSeparatedByString:@":"][0]];
            [xLableArr addObject:[tmpDic stringForKey:@"time"]];
            [yLableArr addObject:[tmpDic stringForKey:@"pac_value"]];
        }
    
        i++;
    }
    //For Line Chart
    
    NSInteger xLableW = 30;
    NSInteger mcount = [xLableArr count];
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, 40+xLableW*mcount, self.ib_sv.frame.size.height)];
    
    [self.ib_sv addSubview:lineChart];
    self.ib_sv.contentSize = CGSizeMake(lineChart.frame.size.width, self.ib_sv.frame.size.height);
    lineChart.showGenYLabels = YES;
    lineChart.backgroundColor = [UIColor clearColor];
    
    lineChart.xLabelColor = [UIColor whiteColor];
    lineChart.xLabelFont = [UIFont systemFontOfSize:8.0];
    lineChart.yLabelColor = [UIColor whiteColor];
    lineChart.showCoordinateAxis = YES;
    
    lineChart.axisColor = [UIColor whiteColor];
    
    [lineChart setXLabels:xLableArr];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:224/255.0 green:192/255.0 blue:147/255.0 alpha:1.0];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        
        CGFloat yValue = [yLableArr[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
}

-(void)setLableText0:(NSDictionary*)textDic
{
    self.ib_textLable1.text = [textDic stringForKey:@"time"];
    self.ib_textLable2.attributedText = [self attributeString:[NSString stringWithFormat:@"%@ %@",[textDic stringForKey:@"pac_value"], @"kW"] rangeStringLenth:2 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
}

-(void)setLableText1:(NSDictionary*)textDic
{
    self.ib_textLable1.text = [textDic stringForKey:@"date"];
    self.ib_textLable2.attributedText = [self attributeString:[textDic stringForKey:@"Text"] rangeStringLenth:3 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
}

-(void)setLableText2:(NSDictionary*)textDic
{
//    {
//        "inverter_value" = "2.098";
//        time = "15:20";
//    }
    self.ib_textLable1.text = [textDic stringForKey:@"time"];
    self.ib_textLable2.attributedText = [self attributeString:[NSString stringWithFormat:@"%@ %@",[textDic stringForKey:@"inverter_value"], @"kW"] rangeStringLenth:2 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
}


-(void)setBarData:(NSArray*)dataArr
{
    self.tmpArr = dataArr;
    
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    
    ViewRadius(self.ib_lbViews, 3);
    
    self.ib_lableText.text = @"(kWh)";
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText1:self.tmpArr[self.tmpArr.count-1]];
    }
    
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];
    
//    NSMutableArray *xShowLableArr = [NSMutableArray new];
//    NSMutableArray *yShowLableArr = [NSMutableArray new];
    
    NSInteger i = 0;
//    CGFloat maxValue = 0.00;
    
    for (NSDictionary *tmpDic in dataArr) {
//        [xShowLableArr addObject:[tmpDic stringForKey:@"date"]];
//        [yShowLableArr addObject:[NSNumber numberWithInteger:[tmpDic integerForKey:@"value"]]];
        
//        if (i%3==0) {
            [xLableArr addObject:[tmpDic stringForKey:@"date"]];
            [yLableArr addObject:[NSNumber numberWithFloat:[tmpDic floatForKey:@"value"]*1.00]];
//        }
        
//        maxValue = [[tmpDic stringForKey:@"inverter_value"] floatValue]>maxValue?[[tmpDic stringForKey:@"inverter_value"] floatValue]:maxValue;
        
        i++;
    }
    //For Line Chart
    
    if (i==0) {
        return;
    }
    
//    NSInteger xLableW = (App_Frame_Width)/i;
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, self.ib_sv.frame.size.height)];
    barChart.backgroundColor = [UIColor clearColor];
    [self.ib_sv addSubview:barChart];
    self.ib_sv.contentSize = CGSizeMake((App_Frame_Width), self.ib_sv.frame.size.height);
    
    barChart.barBackgroundColor = [UIColor clearColor];
    barChart.isGradientShow = NO;
    barChart.isShowNumbers = NO;
    barChart.showLabel = YES;
    barChart.showChartBorder = YES;
    //    barChart.showLevelLine = YES;
    //    barChart.labelFont = [UIFont systemFontOfSize:12.0];
    barChart.labelTextColor = [UIColor whiteColor];
    barChart.labelMarginTop = 24;
    
    barChart.strokeColor = [UIColor colorWithRed:224/255.0 green:192/255.0 blue:147/255.0 alpha:1.0];

    
    [barChart setXLabels:xLableArr];
//    [barChart setYLabels:yLableArr];
//    barChart.yMaxValue = 2.000;
    
    [barChart setYValues:yLableArr];
    barChart.delegate = self;
    
    [barChart strokeChart];
}

-(void)setBarYearData:(NSArray*)dataArr
{
    self.tmpArr = dataArr;
    
    ViewRadius(self.ib_lbViews, 3);
    
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    
    self.ib_lableText.text = @"(kWh)";
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText1:self.tmpArr[self.tmpArr.count-1]];
    }
    
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];
    
//    NSMutableArray *xShowLableArr = [NSMutableArray new];
//    NSMutableArray *yShowLableArr = [NSMutableArray new];
    
    NSInteger i = 0;
    
    for (NSDictionary *tmpDic in dataArr) {
//        [xShowLableArr addObject:[tmpDic stringForKey:@"date"]];
//        [yShowLableArr addObject:[NSNumber numberWithInteger:[tmpDic integerForKey:@"value"]]];
        
        //        if (i%3==0) {
        [xLableArr addObject:[tmpDic stringForKey:@"date"]];
        [yLableArr addObject:[NSNumber numberWithFloat:[tmpDic floatForKey:@"value"]*1.00]];
        //        }
        
        i++;
    }
    //For Line Chart
    
//    NSInteger xLableW = 32;
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, self.ib_sv.frame.size.height)];
    barChart.backgroundColor = [UIColor clearColor];
    [self.ib_sv addSubview:barChart];
    self.ib_sv.contentSize = CGSizeMake(App_Frame_Width, self.ib_sv.frame.size.height);
    barChart.barBackgroundColor = [UIColor clearColor];
    barChart.isGradientShow = NO;
    barChart.isShowNumbers = NO;
    barChart.showLabel = YES;
    barChart.showChartBorder = YES;
//    barChart.showLevelLine = YES;
//    barChart.labelFont = [UIFont systemFontOfSize:12.0];
    barChart.labelTextColor = [UIColor whiteColor];
    barChart.labelMarginTop = 24;
    
    barChart.strokeColor = [UIColor colorWithRed:224/255.0 green:192/255.0 blue:147/255.0 alpha:1.0];
    
    [barChart setXLabels:xLableArr];
    [barChart setYValues:yLableArr];
    barChart.delegate = self;
    
    [barChart strokeChart];
}

-(void)setData:(NSArray*)dataArr
{
    for (UIView *subView in self.ib_sv.subviews) {
        [subView removeFromSuperview];
    }
    self.ib_lableText.text = @"(kW)";
    
    NSMutableArray *xLableArr = [NSMutableArray new];
    NSMutableArray *yLableArr = [NSMutableArray new];
    
    NSMutableArray *xShowLableArr = [NSMutableArray new];
    NSMutableArray *yShowLableArr = [NSMutableArray new];
    
    NSInteger i = 0;
    
    NSInteger k = 1;
    
    if (dataArr.count>=36) {
        k=3;
    }else if(dataArr.count >=24)
    {
        k=2;
    }else if(dataArr.count >=12)
    {
        k=1;
    }else{
        k = 1;
    }
    
    for (NSDictionary *tmpDic in dataArr) {
        [xShowLableArr addObject:[tmpDic stringForKey:@"time"]];
        [yShowLableArr addObject:[tmpDic stringForKey:@"inverter_value"]];
        
        if (i%k==0) {
            [xLableArr addObject:[tmpDic stringForKey:@"time"]];
            [yLableArr addObject:[tmpDic stringForKey:@"inverter_value"]];
        }
//        [xLableArr addObject:[tmpDic stringForKey:@"time"]];
//        [yLableArr addObject:[tmpDic stringForKey:@"inverter_value"]];
//        
        i++;
    }
    //For Line Chart
    
    NSInteger xLableW = 30;
    NSInteger mcount = [xLableArr count];
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, 40+xLableW*mcount, self.ib_sv.frame.size.height)];
    
    [self.ib_sv addSubview:lineChart];
    self.ib_sv.contentSize = CGSizeMake(lineChart.frame.size.width, self.ib_sv.frame.size.height);
    lineChart.showGenYLabels = YES;
    lineChart.backgroundColor = [UIColor clearColor];
    
    lineChart.xLabelColor = [UIColor whiteColor];
    lineChart.xLabelFont = [UIFont systemFontOfSize:8.0];
    lineChart.yLabelColor = [UIColor whiteColor];
    lineChart.showCoordinateAxis = YES;

    lineChart.axisColor = [UIColor whiteColor];

    [lineChart setXLabels:xLableArr];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:224/255.0 green:192/255.0 blue:147/255.0 alpha:1.0];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        
        CGFloat yValue = [yLableArr[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    lineChart.chartData = @[data01];
    [lineChart strokeChart];
}

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex
{
    if (self.showInfo) {
        self.showInfo(barIndex);
    }
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText1:self.tmpArr[barIndex]];
    }
}

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex
{
    if (self.showInfo) {
        self.showInfo(lineIndex);
    }
    
    if (self.tmpArr&&self.tmpArr.count>0) {
        [self setLableText0:self.tmpArr[lineIndex]];
    }
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeStringLenth:(NSInteger)apartStrLength font:(UIFont*)aFont value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:aColor, NSFontAttributeName:aFont} range:firstRange];
    
    //    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    //    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    //    [attributeStr addAttribute:NSFontAttributeName value:aFont range:firstRange];
    return attributeStr;
}

@end
