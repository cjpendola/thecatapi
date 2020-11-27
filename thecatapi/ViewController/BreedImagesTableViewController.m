//
//  BreedImagesTableViewController.m
//  thecatapi
//
//  Created by Carlos Pendola on 11/27/20.
//

#import "BreedImagesTableViewController.h"
#import "Breed.h"
#import "BreedController.h"

@interface BreedImagesViewController ()

@property (nonatomic, copy) NSArray *breedimages;

@end

@implementation BreedImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [[BreedController sharedController] fetchImageForBreed:_breed completion:^(NSArray<Breed *> *  breeds, NSError *error) {
        if (error) {
            NSLog(@"Error %@ on %@:", breeds, error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.breedimages = breeds;
        });
    }];
}

#pragma mark - Properties
- (void)setRover:(Breed *)breed
{
    if (breed != _breed) {
        _breed = breed;
    }
}

@end


