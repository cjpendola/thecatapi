//
//  BreedsListTableViewController.m
//  thecatapi
//
//  Created by Carlos Pendola on 11/26/20.
//

#import "BreedsListTableViewController.h"
#import "BreedImagesTableViewController.h"
#import "Breed.h"
#import "BreedController.h"

@interface BreedsListTableViewController ()

@property (nonatomic, copy) NSArray *breeds;

@end

@implementation BreedsListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [[BreedController sharedController] fetchBreeds:@"" completion:^(NSArray<Breed *> *  breeds, NSError *error) {
        if (error) {
            NSLog(@"Error %@ on %@:", breeds, error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.breeds = breeds;
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.breeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BreedCell" forIndexPath:indexPath];
 
    cell.textLabel.text = [self.breeds[indexPath.row] name];
 
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showBreedImages"]) {
        BreedImagesViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destinationVC.breed = self.breeds[indexPath.row];
    }
}

#pragma mark - Properties

- (void)setBreeds:(NSArray *)breeds
{
    if (breeds != _breeds) {
        _breeds = [breeds copy];
        [self.tableView reloadData];
    }
}

@end

