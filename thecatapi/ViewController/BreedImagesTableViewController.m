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

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperamentLabel;
@property (weak, nonatomic) IBOutlet UILabel *lifeSpanLabel;
@property (weak, nonatomic) IBOutlet UILabel *altNamesLabel;

@property (nonatomic, copy) NSString *breed_url;

@end

@implementation BreedImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.nameLabel.text         = _breed.name;
    self.temperamentLabel.text  = _breed.temperament;
    self.lifeSpanLabel.text     = _breed.life_span;
    self.altNamesLabel.text     = _breed.alt_names;
    
    [[BreedController sharedController] fetchImageForBreed:_breed completion:^(NSString *breed_url, NSError *error) {
        if (error) {
            NSLog(@"Error %@ on %@:", breed_url, error);
            return;
        }
        self.breed_url = breed_url;
        [[BreedController sharedController] fetchCatImage:self.breed_url completion:^(UIImage *image, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.catImageView.image = image;
                [self callTimer];
            });
        }];
    }];
}

- (void)callTimer {
    [NSTimer scheduledTimerWithTimeInterval: 10.0
                      target: self
                      selector:@selector(onTick)
                      userInfo: nil repeats:NO];
}

- (void)onTick {
    [[BreedController sharedController] fetchImageForBreed:_breed completion:^(NSString *breed_url, NSError *error) {
        if (error) {
            NSLog(@"Error %@ on %@:", breed_url, error);
            return;
        }
        self.breed_url = breed_url;
        [[BreedController sharedController] fetchCatImage:self.breed_url completion:^(UIImage *image, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.catImageView.image = image;
                [self callTimer];
            });
        }];
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


