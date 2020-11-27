//
//  BreedController.m
//  thecatapi
//
//  Created by Carlos Pendola on 11/26/20.
//


#import "BreedController.h"
#import "Breed.h"

static NSString * const api_key = @"353b0af2-6a3d-47ea-ae99-b069e251a092";
static NSString * const baseURL = @"https://api.thecatapi.com/v1/breeds";
static NSString * const imagebaseURL = @"https://api.thecatapi.com/v1/images/search";

@implementation BreedController

+ (instancetype) sharedController
{
    static BreedController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [BreedController new];
    });
    return sharedController;
}

- (void)fetchBreeds:(NSString *)searchTerms completion:(void (^)(NSArray<Breed *> *, NSError *))completion
{
    NSURL *baseURL = [BreedController baseURL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItemApiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:api_key];
    NSURLQueryItem *queryItemLimit = [NSURLQueryItem queryItemWithName:@"limit" value:@"10"];
    urlComponents.queryItems = @[queryItemApiKey,queryItemLimit];
    NSURL *endsearchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:endsearchURL completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
        
        if (error) {
            NSLog(@"there was an error  %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"there was an error fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error fetching data %s: %@, %@" ,  __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"Error fetching data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSArray *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        //NSLog(@"%@", jsonDictionary);
        
        NSArray *breedArray = jsonDictionary;
        NSMutableArray *breedsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary *breedDictionary in breedArray) {
            Breed *breed = [[Breed alloc] initWithDictionary: breedDictionary];
            [breedsPlaceholder addObject: breed];
        }
        completion(breedsPlaceholder, nil);
    
    }]resume];
}


- (void) fetchImageForBreed:(Breed *)breed  completion:(void (^)( NSString *, NSError *))completion
{
    NSURL *baseURL = [BreedController imageBaseURL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItemApiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:api_key];
    NSURLQueryItem *queryItemName = [NSURLQueryItem queryItemWithName:@"breed_id" value:breed.id];
    urlComponents.queryItems = @[queryItemApiKey,queryItemName];
    NSURL *endsearchURL = urlComponents.URL;
    
    NSLog(@"%@", endsearchURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:endsearchURL completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
        
        if (error) {
            NSLog(@"there was an error  %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"there was an error fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error fetching data %s: %@, %@" ,  __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"Error fetching data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSArray *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSLog(@"%@", jsonDictionary);
        
        NSArray *breedArray = jsonDictionary;
        NSMutableArray *breedsPlaceholder = [NSMutableArray array];
        NSString *breed_id = @"";
        for (NSDictionary *breedDictionary in breedArray) {
            breed_id = breedDictionary[@"url"];
        }
        completion(breed_id, nil);
    
    }]resume];
}


- (void)fetchCatImage:(NSString *)breed_url completion:(void (^)(UIImage *, NSError * ))completion
{
    NSURL *imageURL = [NSURL URLWithString:breed_url];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        
        if (error) {
            NSLog(@"there was an error  %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"there was an error fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error fetching image %s: %@, %@" ,  __PRETTY_FUNCTION__, error, [error localizedDescription]);
            return completion(nil, [NSError errorWithDomain:@"Error fetching image" code:(NSInteger)-1 userInfo:nil]);
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image, nil);
        
    }]resume];
}


+ (NSURL *)baseURL
{
    return [NSURL URLWithString:baseURL];
}

+ (NSURL *)imageBaseURL
{
    return [NSURL URLWithString:imagebaseURL];
}


@end

