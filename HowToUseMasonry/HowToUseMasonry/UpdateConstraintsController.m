//
//  UpdateConstraintsController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-29.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "UpdateConstraintsController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UpdateConstraintsController ()

@property (nonatomic, strong) UIView *constraintsView;
@property (nonatomic, strong) UIView *frameView;
@property (nonatomic, assign) BOOL constrainIsExpend;
@property (nonatomic, assign) BOOL frameIsExpend;

@end

@implementation UpdateConstraintsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WS(ws);
    
    _constrainIsExpend = NO;
    _frameIsExpend = NO;
    

    UIView *constraintsView = [[UIView alloc] init];
    constraintsView.center = self.view.center;
    constraintsView.backgroundColor = [UIColor redColor];
    constraintsView.layer.borderColor = [UIColor blueColor].CGColor;
    constraintsView.layer.borderWidth = 2;
    [self.view addSubview:constraintsView];
    self.constraintsView = constraintsView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateWithConstraints)];
    [constraintsView addGestureRecognizer:tap];
    [constraintsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view).offset(-SCREEN_HEIGHT/4);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
      
    UIView *frameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    frameView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/4*3);
    frameView.backgroundColor = [UIColor greenColor];
    frameView.layer.borderColor = [UIColor yellowColor].CGColor;
    frameView.layer.borderWidth = 2;
    [self.view addSubview:frameView];
    self.frameView = frameView;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateWithFrame)];
    [frameView addGestureRecognizer:tap2];
    
}

- (void)updateWithConstraints {
    _constrainIsExpend = !_constrainIsExpend;
    
    [self.view setNeedsUpdateConstraints]; //标记为需要更新约束
    [self.view updateConstraintsIfNeeded]; //立即调用updateViewConstraints更新约束, 此方法只是更新了约束, 并没有刷新布局
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];  //动画 刷新布局
        
    }];
}

//不是一定需要把更新约束写在这个方法里, 可以自动一个方法, 苹果推荐使用这个方法更新约束
- (void)updateViewConstraints {
    [self.constraintsView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.constrainIsExpend) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/2));
        } else {

            make.size.mas_equalTo(CGSizeMake(100, 100));
        }
        
    }];
    
    [super updateViewConstraints];
    NSLog(@"updateViewConstraints");
}

- (void)updateWithFrame {
    _frameIsExpend = !_frameIsExpend;
    CGRect frame;
    if (_frameIsExpend) {
        frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    } else {
        frame = CGRectMake(0, 0, 100, 100);
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.frameView.frame = frame;
        self.frameView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/4*3);
        
    }];
}






@end
