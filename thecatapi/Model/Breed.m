//
//  Breed.m
//  thecatapi
//
//  Created by Carlos Pendola on 11/26/20.
//

#import <Foundation/Foundation.h>
#import "Breed.h"

@implementation Breed

-(instancetype) initWithId:(NSString *)id name:(NSString *)name temperament:(NSString *)temperament life_span:(NSString *)life_span alt_names:(NSString *)alt_names{
    self = [super init];
    if (self) {
        _id             = id;
        _name           = name;
        _temperament    = temperament;
        _life_span      = life_span;
        _alt_names      = alt_names;
    }
    return self;
}

-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    NSString *id = dictionary[@"id"];
    NSString *name = dictionary[@"name"];
    NSString *temperament = dictionary[@"temperament"];
    NSString *life_span = dictionary[@"life_span"];
    NSString *alt_names = dictionary[@"alt_names"];
    
    return [self initWithId:id name:name temperament:temperament life_span: life_span alt_names: alt_names];
}

@end
