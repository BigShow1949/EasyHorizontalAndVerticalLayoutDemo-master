//
//  ViewController.m
//  MQHorizontalAndVerticallayout
//
//  Created by macbook on 16/8/12.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YYAdd.h"
#import "RightTableViewCell.h"
#import "RightTableHeaderView.h"
#import "LeftTableHeaderView.h"
#import "HeaderViewProtocol.h"
#import "Model.h"
#import "NSArray+Extension.h"

@interface ViewController () <
    UITableViewDelegate,
    UITableViewDataSource,HeaderViewProtocol>
{
    CGFloat _contentSizeOfX;/**< 计算右侧scrollView的宽度 */
    NSMutableArray <Model *>*_datas;
}
@property (nonatomic, strong) UITableView *leftTableView;/**<侧边栏*/
@property (nonatomic, strong) UIScrollView *rightScrollView;/**<为了实现右滑的效果而创建*/
@property (nonatomic, strong) UITableView *rightTableView;/**<在rightScrollView上面的tableView*/

@end

#define WidthForItem  70
#define HeightForHeader  60
#define HeightForRow  44
#define WidthForLeft  70
#define SelectColor ColorRGB(207, 207, 207)

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息";
    self.view.backgroundColor = ColorWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestDatas];
    [self leftTableView];
    [self rightScrollView];
    [self rightTableView];
}

#pragma mark - rightTableHeaderViewClick
- (void)rightTableHeaderViewClick:(SortType)type{
    
    NSArray *arr = [_datas sortedArrayUsingComparator:^NSComparisonResult(Model *obj1, Model *obj2) {
        
        NSComparisonResult result = NSOrderedDescending; // 默认递减
        switch (type) {
            case SortTypeNumber:
                if (obj1.number.intValue > obj2.number.intValue) return NSOrderedAscending;
                break;
            case SortTypeAge:
                if (obj1.age.intValue > obj2.age.intValue) return NSOrderedAscending;
                break;
            case SortTypeMath:
                if (obj1.math.intValue > obj2.math.intValue) return NSOrderedAscending;
                break;
            case SortTypeChinese:
                if (obj1.chinese.intValue > obj2.chinese.intValue) return NSOrderedAscending;
                break;
            case SortTypeEnglish:
                if (obj1.english.intValue > obj2.english.intValue) return NSOrderedAscending;
                break;
            case SortTypeChemistry:
                if (obj1.chemistry.intValue > obj2.chemistry.intValue) return NSOrderedAscending;
                break;
            default:
                NSLog(@"TypeError");
                break;
        }
        return result;
    }];

    _datas = [NSMutableArray arrayWithArray:arr];
    [self.rightTableView reloadData];
    [self.leftTableView reloadData];
}

#pragma mark - UITableViewDelegate&UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _rightTableView) {
        RightTableHeaderView *headerView = [[RightTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, _contentSizeOfX, HeightForHeader)]; //
        headerView.delegate = self;
        headerView.backgroundColor = ColorWhite;
        [headerView configureWithItem:@[@"年龄", @"数学", @"语文", @"英语", @"化学"]];
        return headerView;
    } else {
        LeftTableHeaderView *view = [[LeftTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, WidthForLeft, HeightForHeader)];
        view.delegate = self;
        [view configureWithItem:@"统计"];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        // 需要判断是哪个tableView
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left"];
        if (_datas.count > 0) {
            
            cell.textLabel.numberOfLines = 2;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = [NSString stringWithFormat:@"%@", _datas[indexPath.row].number];
        }
        return cell;
    } else {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right"];
        cell.widthForItem = WidthForItem;
        cell.heightForItem = HeightForRow;
        Model *myModel = _datas[indexPath.row];
        [cell configureWithItem:myModel];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HeightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  HeightForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rightTableView) {
        if (self.leftTableView.contentOffset.y != self.rightTableView.contentOffset.y) {
            self.leftTableView.contentOffset = CGPointMake(0, self.rightTableView.contentOffset.y);
        }
    } else if (scrollView == self.leftTableView) {
        if (self.rightTableView.contentOffset.y != self.leftTableView.contentOffset.y) {
            self.rightTableView.contentOffset = CGPointMake(self.rightTableView.contentOffset.x, self.leftTableView.contentOffset.y);
        }
    }
}

#pragma mark - 懒加载
- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WidthForLeft, ScreenHeight - 64) style:UITableViewStylePlain];

        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.bounces = NO;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.backgroundColor = ColorWhite;
        [_leftTableView registerClass:[UITableViewCell class]
               forCellReuseIdentifier:@"left"];
        _leftTableView.separatorColor = ColorTableSeparator;
        if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_leftTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_leftTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        [self.view addSubview:_leftTableView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_leftTableView.right - .5, 0, .5, ScreenHeight)];
        
        lineView.backgroundColor = ColorTableSeparator;
        [self.view addSubview:lineView];
    }
    return _leftTableView;
}

- (UIScrollView *)rightScrollView
{
    if (!_rightScrollView) {
        _rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.leftTableView.right, self.leftTableView.top, ScreenWidth  - self.leftTableView.width, self.leftTableView.height)];
        NSLog(@"_contentSizeOfX = %f", _contentSizeOfX);
        _rightScrollView.contentSize = CGSizeMake(_contentSizeOfX, self.leftTableView.height);
        _rightScrollView.bounces = NO;
        _rightScrollView.alwaysBounceVertical = YES;
        _rightScrollView.alwaysBounceHorizontal = NO;
        _rightScrollView.backgroundColor = ColorWhite;
        _rightScrollView.showsVerticalScrollIndicator = NO;
        _rightScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_rightScrollView];
    }
    return _rightScrollView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _contentSizeOfX, self.leftTableView.height)
                                                       style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.bounces = NO;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.backgroundColor = ColorWhite;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView registerClass:[RightTableViewCell class]
                forCellReuseIdentifier:@"right"];
        [self.rightScrollView addSubview:_rightTableView];
    }
    return _rightTableView;
}

#pragma mark ====== 请求数据 =====
- (void)requestDatas
{
    _datas = [NSMutableArray array];
    
    Model *myModel = [[Model alloc] init];
    myModel.number    = @(4);
    myModel.age       = @(20);
    myModel.math      = @(80);
    myModel.chinese   = @(80);
    myModel.english   = @(80);
    myModel.chemistry = @(80);
    [_datas addObject:myModel];
    
    Model *myModel2 = [[Model alloc] init];
    myModel2.number    = @(8);
    myModel2.age       = @(21);
    myModel2.math      = @(81);
    myModel2.chinese   = @(80);
    myModel2.english   = @(80);
    myModel2.chemistry = @(80);
    [_datas addObject:myModel2];
    
    
    Model *myModel3 = [[Model alloc] init];
    myModel3.number    = @(3);
    myModel3.age       = @(19);
    myModel3.math      = @(79);
    myModel3.chinese   = @(80);
    myModel3.english   = @(80);
    myModel3.chemistry = @(80);
    [_datas addObject:myModel3];
    
    Model *myModel4 = [[Model alloc] init];
    myModel4.number    = @(10);
    myModel4.age       = @(2);
    myModel4.math      = @(99);
    myModel4.chinese   = @(80);
    myModel4.english   = @(80);
    myModel4.chemistry = @(80);
    [_datas addObject:myModel4];

    // Model 属性个数
    NSArray *arr = [NSArray getProperties:[Model class]];
    NSLog(@"count = %zd", arr.count);
    _contentSizeOfX = (arr.count-1) * WidthForItem;
}




#pragma mark ====== cell点击  不需要=====

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView || tableView == _rightTableView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeTableViewCellBackgroundColor:NO indexPath:indexPath];
        });
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView || tableView == _rightTableView) {
        [self changeTableViewCellBackgroundColor:YES indexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView || tableView == _rightTableView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeTableViewCellBackgroundColor:NO indexPath:indexPath];
        });
        [self didSelectTableViewCell:tableView indexPath:indexPath];
    }
}

/// cell点击事件
- (void)didSelectTableViewCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    
}

- (void)changeTableViewCellBackgroundColor:(BOOL)change indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = [_leftTableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell2 = [_rightTableView cellForRowAtIndexPath:indexPath];
    if (change) {
        cell1.backgroundColor = SelectColor;
        cell2.backgroundColor = SelectColor;
    } else {
        [UIView animateWithDuration:.2 animations:^{
            cell1.backgroundColor = ColorWhite;
            cell2.backgroundColor = ColorWhite;
        }];
    }
}

@end
