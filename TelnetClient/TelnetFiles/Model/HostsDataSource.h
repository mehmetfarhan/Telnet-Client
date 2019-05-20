//
//  HostsDataSource.h
//  BryanYuan
//
//  Created by Bryan Yuan on 26/12/2016.
//  Copyright © 2016 Bryan Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostEntry : NSObject

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@interface HostsDataSource : NSObject

- (NSString *)hostAtIndex:(NSUInteger)index;
- (NSString *)portAtIndex:(NSUInteger)index;
- (NSString *)usernameAtIndex:(NSUInteger)index;
- (NSString *)passwordAtIndex:(NSUInteger)index;
- (NSUInteger)count;

- (void)insertEntryWithHost:(NSString *)host port:(NSString *)port username:(NSString *)user password:(NSString *)pwd;
- (void)removeEntryAtIndex:(NSUInteger)index;
- (HostEntry *)hostEntryAtIndex:(NSUInteger)index;

@end
