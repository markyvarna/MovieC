//
//  MVMovie.h
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVMovie : NSObject

//Properties
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *overview;
@property (nonatomic, readonly, copy) NSString *imagePath;
@property (nonatomic, readonly) float  rating;


//Init Movie Object
- (instancetype)initWithMovieNamed: (NSString *)title overview: (NSString *)overview rating: (float)rating imagePath: (NSString *)imagePath;

//Init Dictionary
- (instancetype)initWithDictionary: (NSDictionary *)movieDictionary;



@end

NS_ASSUME_NONNULL_END
