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

//fetch the image/images for your breed
-(void) fetchImageForBreed:(Breed *)breed completion:(void(^) (NSArray<Breed *> *cards, NSError *error))completion;

@end
