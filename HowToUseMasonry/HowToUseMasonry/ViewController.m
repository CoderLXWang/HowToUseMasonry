//
//  ViewController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-28.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "ViewController.h"
#import "BasicController.h"
#import "EqualMarginController.h"
#import "UpdateConstraintsController.h"
#import "ScrollViewController.h"
#import "TableViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"HowToUseMasonry";
    
    NSMutableArray *itemArray = [NSMutableArray array];
    [itemArray addObject:@"基本使用"];
    [itemArray addObject:@"等间隙排布"];
    [itemArray addObject:@"更新约束动画"];
    [itemArray addObject:@"ScrollView"];
    [itemArray addObject:@"TableView"];
    
    self.dataArray = [itemArray copy];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            BasicController *basicVC = [BasicController new];
            basicVC.title = @"基本使用";
            [self.navigationController pushViewController:basicVC animated:YES];
        }
            break;
        case 1:
        {
            EqualMarginController *equalVC = [EqualMarginController new];
            equalVC.title = @"等间隙布局";
            [self.navigationController pushViewController:equalVC animated:YES];
        }
            break;
        case 2:
        {
            UpdateConstraintsController *updateVC = [UpdateConstraintsController new];
            updateVC.title = @"更新约束动画";
            [self.navigationController pushViewController:updateVC animated:YES];
        }
            break;
        case 3:
        {
            ScrollViewController *scrollViewVC = [ScrollViewController new];
            scrollViewVC.title = @"ScrollView";
            [self.navigationController pushViewController:scrollViewVC animated:YES];
        }
            break;
        case 4:
        {
            TableViewController *tableViewVC = [TableViewController new];
            tableViewVC.title = @"TableView";
            [self.navigationController pushViewController:tableViewVC animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
