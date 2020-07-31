//
//  NSObject+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ADSuyiKit)

+ (BOOL)adsy_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)adsy_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

- (NSDictionary *)adsy_toDic;

- (nullable id)adsy_PerformSelector:(SEL)action withObject:(id)object, ...NS_REQUIRES_NIL_TERMINATION;

- (NSData *)adsy_serializationToJsonDataWithError:(NSError **)error;

@end

@interface NSArray (ADSuyiKit)

- (nullable id)adsy_objectOrNilAtIndex:(NSUInteger)index;

@end


@interface NSDictionary (ADSuyiKit)

- (nullable id)adsy_objectOrNilForKey:(id)key;

@end


@interface NSMutableDictionary (ADSuyiKit)

- (void)adsy_setValidValue:(id)value forKey:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
