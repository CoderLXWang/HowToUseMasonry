//
//  ScrollViewController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-31.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "ScrollViewController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@end


@implementation ScrollViewController

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; //这个史上最鸡肋的功能凡是涉及到Scrollview及其子类的控制机, 第一句都写上这个, 要么各种布局问题, 不就是个导航栏64啥的, 自己加加更健康 (以下布局, 这个属性为YES, 立即错误)
    
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(-50);
    }];
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(0, 0, 0, 0 ));
        //对于scrollView, 最好把要把想放在scrollView内部的控件, 放在一个容器的View里, 这个View的作用就是衔接内外, 因为scrollView除了自身的frame, 还有containSize, 需要注意的是, 如果仅上面这句话, 会横向撑开, 要实现效果, 一定要一个具体的宽度值, 可以注释掉下面这句话看一下效果, 另外如果不加这个containerView, 那么内部的控件, 就一定要有具体的宽度值
        make.width.mas_equalTo(self.scrollView);
    }];
    
    
    UIView *lastView; //定义一个指向上一个View的指针, 以便循环中获取上一个View, 相对这个View布局
    for (NSInteger i = 0; i < 10; i++) {
        UILabel *content = [[UILabel alloc] init];
        content.backgroundColor = [UIColor blueColor];
        content.numberOfLines = 0;
        content.text = [self getRandomLengthStr];
        [self.containerView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.containerView).offset(20);
            make.right.equalTo(self.containerView).offset(-20);
            //第一个label时顶部要针对containerView 布局, 之后的label都要针对上一个label
            if (i == 0) {
                make.top.equalTo(self.containerView).offset(20);
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(10);
            }
            //最后一个label, 要记得对containerView底部约束, 这样才会"撑满", 或者放在循环结束, 对最后一个lastView约束也可以
            if (i == 9) {
                make.bottom.equalTo(self.containerView).offset(-20);
            }
        }];
        
        lastView = content;
    }
    
//    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(lastView).offset(20);
//    }];
    
}

- (NSString *)getRandomLengthStr {
    NSMutableString *str = [NSMutableString string];
    for (NSInteger i = 0; i < (arc4random() % 50) + 10; i++) {
        [str appendString:@"测试一下 "];
    }
    return [str copy];
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
