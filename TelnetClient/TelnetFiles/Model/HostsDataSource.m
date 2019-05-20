//
//  HostsDataSource.m
//  BryanYuan
//
//  Created by Bryan Yuan on 26/12/2016.
//  Copyright © 2016 Bryan Yuan. All rights reserved.
//

#import "HostsDataSource.h"

#define BY_KEY_TELNET_HOSTS                 @"TelnetHosts"
#define TELNET_KEYS_HOST                    @"host"
#define TELNET_KEYS_PORT                    @"port"
#define TELNET_KEYS_USER                    @"user"
#define TELNET_KEYS_PWD                     @"passwd"

@implementation HostEntry

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@", [super description], self.host, self.port, self.username];
}

@end
@interface HostsDataSource ()

@property NSMutableArray<HostEntry *> *hostsArray;
@end

@implementation HostsDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hostsArray = [self loadProperty];
    }
    return self;
}

- (NSString *)identifier
{
    return BY_KEY_TELNET_HOSTS;
}

-(NSMutableArray<HostEntry *> *)loadProperty
{
    NSUserDefaults *localPref = [NSUserDefaults standardUserDefaults];
    NSArray *temp = [localPref objectForKey:[self identifier]];
    
    if (!temp) {
        temp = @[@{TELNET_KEYS_HOST:@"192.168.88.123"}];
    }
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in temp) {
        HostEntry *prop = [[HostEntry alloc] init];
        prop.host = [dict valueForKey:TELNET_KEYS_HOST];
        prop.port = [dict valueForKey:TELNET_KEYS_PORT];
        prop.username = [dict valueForKey:TELNET_KEYS_USER];
        prop.password = [dict valueForKey:TELNET_KEYS_PWD];
        
        if (!prop.port) {
            prop.port = @"23";
        }
        
        [propertyArray addObject:prop];
    }
    
    return propertyArray;
}

- (void)dumpProperty
{
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    for (HostEntry *hostEntry in self.hostsArray) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:hostEntry.host forKey:TELNET_KEYS_HOST];
        if (hostEntry.port) {
            [dict setValue:hostEntry.port forKey:TELNET_KEYS_PORT];
        }
        if (hostEntry.username) {
            [dict setValue:hostEntry.username forKey:TELNET_KEYS_USER];
        }
        if (hostEntry.password) {
            [dict setValue:hostEntry.password forKey:TELNET_KEYS_PWD];
        }
        
        [propertyArray addObject:dict];
    }
    
    NSArray *inmutableArray = [NSArray arrayWithArray:propertyArray];
    NSUserDefaults *localPref = [NSUserDefaults standardUserDefaults];
    [localPref setObject:inmutableArray forKey:[self identifier]];
    return;
}

- (NSString *)hostAtIndex:(NSUInteger)index
{
    HostEntry *hostEntry = [self.hostsArray objectAtIndex:index];
    return [hostEntry host];
}
- (NSString *)portAtIndex:(NSUInteger)index
{
    HostEntry *hostEntry = [self.hostsArray objectAtIndex:index];
    NSString *port = [hostEntry port];
    if (!port) {
        port = @"23";
    }
    return port;
}
- (NSString *)usernameAtIndex:(NSUInteger)index
{
    HostEntry *hostEntry = [self.hostsArray objectAtIndex:index];
    return [hostEntry username];
}
- (NSString *)passwordAtIndex:(NSUInteger)index
{
    HostEntry *hostEntry = [self.hostsArray objectAtIndex:index];
    return [hostEntry password];
}
- (NSUInteger)count
{
    return self.hostsArray.count;
}

- (void)insertEntryWithHost:(NSString *)host port:(NSString *)port username:(NSString *)user password:(NSString *)pwd
{
    if (!host) {
        return;
    }
    
    HostEntry *hostEntry = [[HostEntry alloc] init];
    hostEntry.host = host;
    hostEntry.port = port;
    hostEntry.username = user;
    hostEntry.password = pwd;
    
    [self.hostsArray addObject:hostEntry];
    [self dumpProperty];
}

- (void)removeEntryAtIndex:(NSUInteger)index
{
    if (index >= self.hostsArray.count) {
        return;
    }
    
    [self.hostsArray removeObjectAtIndex:index];
    [self dumpProperty];
}

- (HostEntry *)hostEntryAtIndex:(NSUInteger)index
{
    HostEntry *hostEntry = [self.hostsArray objectAtIndex:index];
    return hostEntry;
}

@end
