//
//  MVMovieClient.h
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVMovieClient : NSObject

+ (instancetype)sharedClient;

- (void)fetchMovieBySearchTerm: (NSString *)searchTerm withBlock: (void(^)(NSArray<MVMovie *>*))block;

- (void)fetchImageForMovie: (MVMovie *)movie withBlock:(void (^) (UIImage *))block;

@end

NS_ASSUME_NONNULL_END
