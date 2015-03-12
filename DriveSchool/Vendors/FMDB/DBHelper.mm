//
//  DBHelper.m
//  HSYS
//
//  Created by 王 焕 on 12-10-30.
//  Copyright (c) 2012年 王 焕. All rights reserved.
//

#import "DBHelper.h"

//数据库
#define DATABASE_NAME @"driveSchool.db"
#define DATABASE_PATH(db_name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:db_name]

@implementation DBHelper

- (BOOL)initDatabase
{
    BOOL success;
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *writableDBPath = DATABASE_PATH(DATABASE_NAME);
    NSLog(@"DATABASE_PATH : %@", DATABASE_PATH(DATABASE_NAME));
    success = [fm fileExistsAtPath:writableDBPath];
    
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath]
                                   stringByAppendingPathComponent:DATABASE_NAME];
        NSLog(@"defaultDBPath:%@",defaultDBPath);
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success){
            NSLog(@"error: %@", [error localizedDescription]);
        }
        success = YES;
        NSLog(@"Success to open database.:%@", DATABASE_PATH(DATABASE_NAME));
    }
    
    if(success){
        db = [FMDatabase databaseWithPath:writableDBPath];
        if ([db open]) {
            [db setShouldCacheStatements:YES];
        }else{
            NSLog(@"Failed to open database.");
            success = NO;
        }
    }
    return success;
}

- (void)closeDatabase
{
    [db close];
}

- (FMDatabase *)getDatabase
{
    if ([self initDatabase])
        return db;
    
    return NULL;
}

@end
