//
//  Document.m
//  Test
//
//  Created by Alex on 2012-12-28.
//  Copyright (c)  2012 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject{
    NSString *Name;
    NSString *Path;
    NSString *Extension;
    NSString *Content; 
}

-(NSString *) name;
-(NSString *) path;
-(NSString *) extension;
-(NSString *) content;

-(void) save;
-(void) print;
-(void) open:(NSURL *) pathURL;
-(void) saveAs:(NSString *) path;
-(void) setContent:(NSString *) content;

@end