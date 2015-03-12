//
//  DBHelper.h
//  HSYS
//
//  Created by 王 焕 on 12-10-30.
//  Copyright (c) 2012年 王 焕. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"

@interface DBHelper : NSObject
{
    FMDatabase *db;
}

-(BOOL) initDatabase;
-(void) closeDatabase;
-(FMDatabase *) getDatabase;

@end


/*
 
 DBHelper *dbHelper = [[DBHelper alloc] init];
 FMDatabase *db = [dbHelper getDatabase]; 
 FMResultSet *rs = [db executeQuery:@"SELECT value FROM config WHERE flag = 'about_us'"];
 
 while ([rs next]) {
     CGSize maximumLabelSize = CGSizeMake(250 ,MAXFLOAT);
     expectedLabelSize = [[rs stringForColumn:@"value"] sizeWithFont:[UIFont systemFontOfSize:14.0f]
     constrainedToSize:maximumLabelSize
     lineBreakMode:UILineBreakModeWordWrap];
 }
 [rs close];
 [dbHelper closeDatabase];
 
 
 DBHelper *dbHelper = [[DBHelper alloc] init];
 FMDatabase *db = [dbHelper getDatabase];
 [db beginTransaction];
 [db executeUpdate:@"DELETE FROM CLASS"];
 
 if ([db hadError]) {
 NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    [db rollback];
 }
 [db commit];
 [dbHelper closeDatabase];
 
 */
