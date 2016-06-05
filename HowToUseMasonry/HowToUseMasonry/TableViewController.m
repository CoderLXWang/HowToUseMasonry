//
//  TableViewController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-31.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "TableViewController.h"
#import "JSONModel.h"
#import "Masonry.h"
#import "BestSelectModel.h"
#import "TestCell.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kAPI (@"http://api.zsreader.com/v2/pub/home/2?&page=1&tp=1&size=20")

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation TableViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //要cell高度自适应需要先设置一个预设高度, 这个高度只有"大概"差不多就可以, 比如cell高度大致在20~200之间, 设置100就可以, 其实设置200, 300都可以, 设置的尽量差不多, 性能会好一些, 如果相邻两个cell高度相差极大, 可能会出现跳动的现象, 这个estimatedRowHeight 也可以通过estimatedHeightForRowAtIndexPath 设置
        _tableView.estimatedRowHeight = 200;
        //如果tableview分为多组, 有一些组需要自动高度, 有一些则固定高度, 可以在heightForRowAtIndexPath 中return UITableViewAutomaticDimension
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:kAPI] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        

        NSDictionary *respomseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSArray *array = respomseDic[@"data"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            BestSelectModel *model = [[BestSelectModel alloc] initWithDictionary:dic error:nil];
            [dataArray addObject:model];
        }
        _dataArray = [dataArray copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData]; //更新UI要回到主线程, 如果使用afNetworking, 不需要这样操作, 因为af已经做了相关操作
        });
        
    }];
    
    [task resume];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TestCell alloc] init];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
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
