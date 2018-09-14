//
//  MVMovie.m
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import "MVMovie.h"

@implementation MVMovie

//Init MVMovie Object

- (instancetype)initWithMovieNamed: (NSString *)title overview: (NSString *)overview rating: (float)rating imagePath: (NSString *)imagePath
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _overview = [overview copy];
        _rating = rating;
        _imagePath = [imagePath copy];
    }
    return self;
}

//Init Dictionary

- (instancetype)initWithDictionary: (NSDictionary *)movieDictionary
{
  //assign dictionary keys to its values
    NSString *title = movieDictionary[[MVMovie titleKey]];
    NSString *overview = movieDictionary[[MVMovie overviewKey]];
    NSString *imagePath = movieDictionary[[MVMovie imagePathKey]];
    float rating = [movieDictionary[[MVMovie ratingKey]] floatValue];
    
    return [self initWithMovieNamed:title overview:overview rating:rating imagePath:imagePath];
}

//Dictionary KEYS

+ (NSString *)titleKey
{
    return @"title";
}

+ (NSString *)ratingKey
{
    return @"vote_average";
}

+ (NSString *)overviewKey
{
    return @"overview";
}

+ (NSString *)imagePathKey
{
    return @"poster_path";
}

@end
