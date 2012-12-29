//
//  Document.m
//  Test
//
//  Created by Alex on 2012-12-28.
//  Copyright (c) 2012 Alex. All rights reserved.
//

#import "Document.h"

@implementation Document

-(NSString *)name{
    return Name;
}
-(NSString *)path{
    return Path;
}
-(NSString *)extension{
    return Extension;
}
-(NSString *)content{
    return Content;
}

- (void)open:(NSURL *)pathURL{
    NSString *path = [NSString stringWithFormat:@"%@",pathURL];
    path = [path stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
    
    NSError *error = nil; 
    Content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if(error)
        NSLog(@"error: %@", error.localizedFailureReason);
    
    Path = path;
    
    
    
    //Extract the extension
    NSRange range = [Path rangeOfString:@"." options:NSBackwardsSearch];
    if(range.location != NSNotFound){
        Extension = [Path substringFromIndex:range.location+1];
    }

    
    Name = [[Path lastPathComponent] stringByDeletingPathExtension]; 
}



-(void)save{

    if(!Content){
        Content = @"";
    }
    if(!Path) {
        NSSavePanel *panel	= [NSSavePanel savePanel];
        [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"adb",@"ads", nil]];
        [panel setAllowsOtherFileTypes:YES];
        [panel setNameFieldStringValue:@"untitled.adb"];
        [panel canSelectHiddenExtension]; 
        if([panel runModal] == NSOKButton){
            Path = [NSString stringWithFormat:@"%@",[panel URL]];
            Path = [Path stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
        }
        else {
            NSLog(@"You must save the file before compiling.");
            return;
        }
    }
    
    
    
    //Extract the extension
    NSRange range = [Path rangeOfString:@"." options:NSBackwardsSearch];
    if(range.location != NSNotFound){
        Extension = [Path substringFromIndex:range.location+1];
        
        if(!Extension){
            Path = [NSString stringWithFormat:@"%@.adb",Path];
            Extension = @"adb";
        }
        
    }
    else
        Extension=@"";
    
    
    //Extract file name
    Name = [[Path lastPathComponent] stringByDeletingPathExtension];
    [self saveAs:Path];
}

- (void)saveAs:(NSString *)path{
    path = [path stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
    NSLog(@"Saving %@.%@ in %@.",Name, Extension, path);

    NSError *error = nil;
    [Content writeToFile:path
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:&error];
    if(error)
        NSLog(@"error: %@", error.localizedFailureReason);
}




- (void)run{
   NSLog(@"running...");
}

- (void)setContent:(NSString *)content{
    NSLog(@"Set content");
    Content = content; 
}




- (void)print{
    NSLog(@"Print");
}


@end
