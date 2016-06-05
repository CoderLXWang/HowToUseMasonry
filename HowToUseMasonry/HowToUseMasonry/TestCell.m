//
//  TestCell.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-31.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "TestCell.h"
#import "BestSelectModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface TestCell ()

@property (nonatomic, strong) UIImageView *bookImgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *authorLabel;

@end

@implementation TestCell

- (UIImageView *)bookImgView
{
    if (!_bookImgView) {
        _bookImgView = [[UIImageView alloc] init];
    }
    return _bookImgView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.numberOfLines = 0;
    }
    return _authorLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    [self.contentView addSubview:self.bookImgView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.contentLabel];
    
}

- (void)layoutView {
    [self.bookImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.authorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImgView.mas_bottom).offset(10);
        make.left.equalTo(self.bookImgView).offset(0);
    }];
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.bookImgView);
        make.width.mas_equalTo(200);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    

}

- (void)setModel:(BestSelectModel *)model {
    _model = model;
    
    [self.bookImgView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.authorLabel.text = model.name;
    self.contentLabel.text = model.desc;
    
    [self layoutView];

}

@end
