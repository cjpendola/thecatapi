//
//  Breed.h
//  thecatapi
//
//  Created by Carlos Pendola on 11/26/20.
//

#import <Foundation/Foundation.h>

#ifndef Breed_h
#define Breed_h

@interface Breed : NSObject

@property (nonatomic, readonly, copy) NSString *id;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *temperament;
@property (nonatomic, readonly, copy) NSString *life_span;
@property (nonatomic, readonly, copy) NSString *alt_names;

-(instancetype) initWithId:(NSString *)id
                      name:(NSString *)name
               temperament:(NSString *)temperament
                 life_span:(NSString *)life_span
                 alt_names:(NSString *)alt_names;

@end

@interface Breed (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;


@end






#endif /* Breed_h */
