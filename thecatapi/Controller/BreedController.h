//
//  BreedController.h
//  thecatapi
//
//  Created by Carlos Pendola on 11/26/20.
//

#import <UIKit/UIKit.h>
#import "Breed.h"


@interface BreedController : NSObject

//singleton
+(instancetype) sharedController;

//source of truth
@property (nonatomic, copy) NSArray<Breed *> *breeds;

//fetch your Breed
-(void) fetchBreeds:(NSString *)searchTerm completion:(void(^) (NSArray<Breed *> *cards, NSError *error))completion;

//fetch the url string for your breed
-(void) fetchImageForBreed:(Breed *)breed completion:(void(^) (NSString *breed_url, NSError *error))completion;

//fetch the image for your url breed
- (void)fetchCatImage:(NSString *)breed_url completion:(void(^) (UIImage *image, NSError *error))completion;

@end
