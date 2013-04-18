//
//  OAI_FileManager.m
//  OAI_IntegrationSiteReport_v1
//
//  Created by Steve Suranie on 11/14/12.
//  Copyright (c) 2012 Steve Suranie. All rights reserved.
//

#import "OAI_FileManager.h"

@implementation OAI_FileManager


+(OAI_FileManager *)sharedFileManager {
    
    static OAI_FileManager* sharedFileManager;
    
    @synchronized(self) {
        
        if (!sharedFileManager)
            
            sharedFileManager = [[OAI_FileManager alloc] init];
        
        return sharedFileManager;
        
    }
    
}

-(id)init {
    
    if (self = [super init]) {
        
        //set up a file manager and error container
       fileManager=[NSFileManager defaultManager];
        
        //docs directory path
        documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        
    }
    
    return self;
}

- (NSDictionary* ) readPlist : (NSString* ) plistToRead {
    
    //set up an error 
    NSError* error;
    
    //set path to plist to read in docs directory
    NSString* plistPath = [documentsDirectory stringByAppendingPathComponent:plistToRead];
    
    //check to see if the file exists
    if ([fileManager fileExistsAtPath:plistPath]) {
        
        //read file
        NSDictionary* fileData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        return fileData;
        
    } else {
        
        //file doesn't exist in doc directory, check to see if it is in the bundle
        NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:plistToRead];
        
        if ([fileManager fileExistsAtPath:sourcePath]) { 
            
            //copy the file from the bundle to the docs directory
            bool success = [fileManager copyItemAtPath:sourcePath toPath:plistPath error:&error];
            
            if (success) {
                
                //read file
                NSDictionary* fileData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
                return fileData;
            }
        
        } else {
            
            
        
        }
        
    }
    
    return 0;
}

- (BOOL) writeToPlist : (NSString* ) plistToWrite : (NSDictionary* ) plistData {
    
    BOOL success = YES;
    
    //set path to plist to read in docs directory
    NSString* plistPath = [documentsDirectory stringByAppendingPathComponent:plistToWrite];
    
    if ([fileManager fileExistsAtPath:plistPath]) {
        
        success = [plistData writeToFile:plistPath atomically:YES];
    }
    
    if (success) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void) createPlist : (NSString* ) filePath {
    
    //set path to plist to read in docs directory
    NSString* plistPath = [documentsDirectory stringByAppendingPathComponent:filePath];
    
    //if it doesn't exists, create it
    if(![fileManager fileExistsAtPath:plistPath]) {
        
        //break the path apart
        NSArray* plistPathItems = [plistPath componentsSeparatedByString:@"/"];
        
        //get the last item (this is our filename)
        NSString* fileName = [plistPathItems objectAtIndex:plistPathItems.count-1];
        
        //create a dictionary and populate with filename
        NSDictionary* dataDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        fileName, @"File Name",
                                        nil];

        [dataDictionary writeToFile: plistPath atomically:YES];
    }
    
}

- (void) createDirectory : (NSString* ) directoryName {
    
    //set up a holder for any errors
    NSError* error;
    
    //set path to the directory
    NSString* directoryPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", directoryName]];
    
    BOOL isDir;
    BOOL exists = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
        
    if (!exists){
        
        if([fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:&error]) { 
            ;// success
        } else {
            NSLog(@"[%@] ERROR: attempting to write create MyFolder directory", [self class]);
            NSAssert( FALSE, @"Failed to create directory maybe out of disk space?");
        }
    } 
}

//check if plist exists
- (BOOL) checkIfExists : (NSString* ) filePath {
    
    //set path to plist to read in docs directory
    NSString* plistPath = [documentsDirectory stringByAppendingPathComponent:filePath];
    
    if(![fileManager fileExistsAtPath:plistPath]) {
        return NO;
    } else {
        return YES;
    }
}

- (void) moveFileToDocDirectory : (NSString*) strFilename : (NSString*) strErrMsg {
    
    //set path to file in docs directory
    NSString* sourcePath = [documentsDirectory stringByAppendingPathComponent:strFilename];
    
    NSString* bundleFilePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:strFilename];
    
    NSError* error;
    
    //check to see if the file exists
    if (![fileManager fileExistsAtPath:sourcePath]) {
        
        //move the file to the docs directory
        [fileManager copyItemAtPath:bundleFilePath toPath:sourcePath error:&error];
    }
    
}

- (void) mergerPDFFiles : (NSString*) firstPDFFile : (NSString* ) secondPDFFile {
    
    //set path to plist to read in docs directory
    NSString* pdf1Path = [documentsDirectory stringByAppendingPathComponent:firstPDFFile];
    NSString* pdf2Path = [documentsDirectory stringByAppendingPathComponent:secondPDFFile];
    
    BOOL hasError = NO;
    NSMutableString* strErrMsg = [[NSMutableString alloc] init];
    
    //check to see if the file exists
    if (![fileManager fileExistsAtPath:pdf1Path]) {
        hasError = YES;
        [strErrMsg appendString:[NSString stringWithFormat:@"Could not find the PDF just created: %@", firstPDFFile]];
    }
    
    //check to see if the file exists
    if (![fileManager fileExistsAtPath:pdf2Path]) {
        hasError = YES;
        [strErrMsg appendString:[NSString stringWithFormat:@"Could not find the marketing materials PDF: %@", secondPDFFile]];
    }
    
    if (!hasError) {
        
        NSArray* arrPDFPaths = [[NSArray alloc] initWithObjects:pdf1Path, pdf2Path, nil];
        
        //make a new file name
        NSArray* arrPDF1Split = [firstPDFFile componentsSeparatedByString:@"."];
        NSString* strNewPDF = [NSString stringWithFormat:@"%@_Complete.pdf", [arrPDF1Split objectAtIndex:0]];
        
        // File paths
        NSString* pdfPathOutput = [documentsDirectory stringByAppendingPathComponent:strNewPDF];
        
        CFURLRef pdfURLOutput = (__bridge CFURLRef)[[NSURL alloc] initFileURLWithPath:pdfPathOutput];
        NSInteger numberOfPages = 0;
        
        // Create the output context
        
        CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, NULL);
        
        
        //loop through the pdfs
        for(int i=0; i<arrPDFPaths.count; i++) {
            
            //get the file
            NSString* pdfSource = [arrPDFPaths objectAtIndex:i];
            
            //set a CFURL to the pdf
            CFURLRef pdfURL = (__bridge CFURLRef)[[NSURL alloc] initFileURLWithPath:pdfSource];
           
            //set a reference to the pdf
            CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef) pdfURL);
            numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
            
            //set some ivars
            CGPDFPageRef page;
            CGRect mediaBox;
            
            // Read the first PDF and generate the output pages
            NSLog(@"GENERATING PAGES FROM PDF (%@)...", pdfSource);
            for (int x=1; x<=numberOfPages; x++) {
                page = CGPDFDocumentGetPage(pdfRef, x);
                mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
                CGContextBeginPage(writeContext, &mediaBox);
                CGContextDrawPDFPage(writeContext, page);
                CGContextEndPage(writeContext);
            }
            
            CGPDFDocumentRelease(pdfRef);
            CFRelease(pdfURL);
            
        }
        
        CFRelease(pdfURLOutput);
        
        // Finalize the output file
        CGPDFContextClose(writeContext);
        CGContextRelease(writeContext);
                
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]
          initWithTitle: @"Error Merging PDF Files"
          message: strErrMsg
          delegate: nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:
        nil];
        [alert show];
    }
    
}



- (NSString* ) dateToString : (NSDate* ) dateToConvert {
   
    //format the date string
    NSDateFormatter* formatter;
    NSString* dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy Time: HH:mm:ss"];
    
    dateString = [formatter stringFromDate:dateToConvert];
    
    return dateString;
    
}


@end
