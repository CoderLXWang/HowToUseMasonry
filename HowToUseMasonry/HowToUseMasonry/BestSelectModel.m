//
//  BestSelectModel.m
//  BestAbstract
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BestSelectModel.h"

@implementation BestSelectModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"user.icon":@"icon",
                                                       @"user.id":@"userId",
                                                       @"id":@"abstractId",
                                                       @"user.name":@"name",
                                                       @"thumbnail.url":@"url"}];
}

@end
