//
//  RRNewsManager.m
//  RSSReader
//
//  Created by Timofey Taran on 31.01.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import "RRNewsManager.h"
#import "RRXMLParser.h"
#import "RRNewsData.h"

NSString* const RRDataManagerDidUpdateNewsNotification = @"RRDataManagerDidUpdateNewsNotification";
NSString* const RRDataManagerNewsUserInfoKey = @"RRDataManagerNewsUserInfoKey";


@interface RRNewsManager () <RRXMLParserDelegate>

@property (nonatomic) NSArray<NSString *> *newsTabArray;
@property (nonatomic) NSArray<NSString *> *newsLinkArray;
@property (nonatomic) NSMutableDictionary *newsDictionary;

@property (nonatomic) RRXMLParser *xmlParser;


@end


@implementation RRNewsManager


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _newsTabArray = @[ @"В мире", @"Россия", @"Культура",
                               @"Финансы", @"Бизнес", @"Наука",
                               @"Спорт", @"Интернет", @"Ценности"
                               ];
        _newsLinkArray = @[ @"https://lenta.ru/rss/news/world",
                                @"https://lenta.ru/rss/news/russia",
                                @"https://lenta.ru/rss/news/culture",
                                @"https://lenta.ru/rss/news/economics",
                                @"https://lenta.ru/rss/news/business",
                                @"https://lenta.ru/rss/news/science",
                                @"https://lenta.ru/rss/news/sport",
                                @"https://lenta.ru/rss/news/media",
                                @"https://lenta.ru/rss/news/style"
                                ];
        _xmlParser = [[RRXMLParser alloc] init];
        _xmlParser.delegate = self;
        
        _newsDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}


+ (RRNewsManager*)sharedManager
{
    static RRNewsManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[RRNewsManager alloc] init];
    });
    
    return manager;
}


#pragma mark - RRNewsManager Methods

- (NSArray<RRNewsData *> *)getNewsWithTag:(NSString *)tag
{
    NSArray<RRNewsData *> *newsArray = self.newsDictionary[tag];
    if (!newsArray)
    {
        NSInteger tagIndex = [self.newsTabArray indexOfObject:tag];
        [self.xmlParser parseXMLWithURLString:self.newsLinkArray[tagIndex]];
    }
    return newsArray;
}


- (void)updateNewsWithTag:(NSString *)tag
{
    NSInteger tagIndex = [self.newsTabArray indexOfObject:tag];
    [self.xmlParser parseXMLWithURLString:self.newsLinkArray[tagIndex]];
}


- (NSString *)tagWithURLString:(NSString *)urlString
{
    NSInteger tagIndex = [self.newsLinkArray indexOfObject:urlString];
    return self.newsTabArray[tagIndex];
}


- (void)sendNotificationWithDictionary:(NSDictionary *)dict
{
    NSDictionary* dictionary = @{RRDataManagerNewsUserInfoKey : dict};
    [[NSNotificationCenter defaultCenter] postNotificationName:RRDataManagerDidUpdateNewsNotification object:self userInfo:dictionary];
}


#pragma mark - RRXMLParserDelegate

- (void)parser:(RRXMLParser *)parser didFinishWithResult:(NSArray<NSDictionary *> *)resultArray urlString:(NSString *)urlString
{
    NSMutableArray *newsArray = [NSMutableArray array];
    
    if (resultArray.count >= 10)
    {
        for (int i = 0; i < 10; i++)
        {
            NSDictionary *dict = resultArray[i];
            
            RRNewsData *news = [[RRNewsData alloc] init];
            news.imageURLString = dict[RRXMLParserImageURLString];
            news.pubDate = dict[RRXMLParserPubDateString];
            news.header = dict[RRXMLParserHeader];
            news.text = dict[RRXMLParserDescription];
            news.link = dict[RRXMLParserLink];
            
            [newsArray addObject:news];
        }
    }
    
    NSString *tag = [self tagWithURLString:urlString];
    
    self.newsDictionary[tag] = [newsArray copy];
    
    [self sendNotificationWithDictionary:@{tag : [newsArray copy]}];
}


@end
