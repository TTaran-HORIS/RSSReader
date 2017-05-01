//
//  RRNewsData.h
//  RSSReader
//
//  Created by Timofey Taran on 19.01.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RRNewsData : NSObject

@property (nonatomic) NSString *imageURLString;
@property (nonatomic) NSString *pubDate;
@property (nonatomic) NSString *header;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *link;

@end
