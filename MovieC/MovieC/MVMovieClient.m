//
//  MVMovieClient.m
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import "MVMovieClient.h"
#import <UIKit/UIKit.h>
#import "MVMovie.h"

@implementation MVMovieClient

//Shared Client

+ (MVMovieClient *)sharedClient
{
    static MVMovieClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [MVMovieClient new];
    });
    return sharedClient;
}

//BaseURLs

- (NSURL *)baseURL
{
    return [NSURL  URLWithString:@"https://api.themoviedb.org/3/search/movie"];
}

- (NSURL *)imageBaseURL
{
    return [NSURL URLWithString:@"https://image.tmdb.org/t/p/w500/"];
}

//Fetch Movie

- (void)fetchMovieBySearchTerm: (NSString *)searchTerm withBlock: (void(^)(NSArray<MVMovie *>*))block
{
     NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[self baseURL] resolvingAgainstBaseURL:true];
    
    //Query Items
    NSURLQueryItem *apiKeyQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:@"4c5ab512bcf7e4578d8704902773141d"];
    NSURLQueryItem *languageQuery = [NSURLQueryItem queryItemWithName:@"language" value:@"en-US"];
    NSURLQueryItem *movieSearchQuery = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    //array literal of query items
    urlComponents.queryItems = @[apiKeyQuery, languageQuery, movieSearchQuery];
    
    //URLSession
    [[[NSURLSession sharedSession] dataTaskWithURL:urlComponents.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error){
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"NO DATA AVAILABLE");
            block(nil);
            return;
        }
        
        //JSON Serialization
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *results = jsonDictionary[@"results"];
        NSMutableArray *movies = [NSMutableArray new];
        
        //Loop through results arrayand pull the movie dictionary objects out
        for (NSDictionary *movieDictionary in results)
        {
            MVMovie *movie = [[MVMovie alloc]initWithDictionary:movieDictionary];
            //store the movie dict obj in the movies NSMutableArray
            [movies addObject:movie];
        }
        
        block(movies);
        
    }]resume];
    
}

//Fetch Image

- (void)fetchImageForMovie: (MVMovie *)movie withBlock:(void (^) (UIImage *))block
{
    
     NSURL *imageURL = [[self imageBaseURL] URLByAppendingPathComponent:movie.imagePath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error){
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"NO DATA AVAILABLE");
            block(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        block(image);
        
    }] resume];
    
}

@end
