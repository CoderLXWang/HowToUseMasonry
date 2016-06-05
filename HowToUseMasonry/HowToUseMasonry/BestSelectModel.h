//
//  BestSelectModel.h
//  BestAbstract
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface BestSelectModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *icon;
@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *channelName;
@property (nonatomic, copy) NSString<Optional> *channel;
@property (nonatomic, copy) NSString<Optional> *ct;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *url;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *cmt;
@property (nonatomic, copy) NSString<Optional> *praise;
@property (nonatomic, copy) NSString<Optional> *abstractId;

@end
