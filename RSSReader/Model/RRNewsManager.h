//
//  RRNewsManager.h
//  RSSReader
//
//  Created by Timofey Taran on 31.01.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RRNewsData;

extern NSString* const RRDataManagerDidUpdateNewsNotification;
extern NSString* const RRDataManagerNewsUserInfoKey;


@interface RRNewsManager : NSObject

@property (nonatomic, readonly) NSArray<NSString *> *newsTabArray;

+ (RRNewsManager*)sharedManager;
- (NSArray<RRNewsData *> *)getNewsWithTag:(NSString *)tag;
- (void)updateNewsWithTag:(NSString *)tag;


@end
