//
//  EnmlConverter.m
//  EnmlConverter
//
//  Created by Jiang Chuncheng on 3/12/15.
//  Copyright (c) 2015 SenseForce. All rights reserved.
//

#import "EnmlConverter.h"

#import <hpple/TFHpple.h>
#import <MWFeedParser/NSString+HTML.h>
#import <CTidy/CTidy.h>

#define SF_DEBUG 0

@interface EnmlConverter ()

- (void)travelHtmlNode:(TFHppleElement*)element withENML:(NSMutableString*)enml withDumpedDict:(NSMutableDictionary*)dumpedDict;
- (void)travelHtmlLeaf:(TFHppleElement*)element withENML:(NSMutableString*)enml withDumpedDict:(NSMutableDictionary*)dict;

@end

@implementation EnmlConverter

+ (instancetype)sharedInstance {
    static EnmlConverter* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[EnmlConverter alloc] init];
    });
    return _sharedInstance;
}

- (NSString*)convertToENML:(NSString*)html {
    NSMutableDictionary* dumpedDict = [NSMutableDictionary new];
    
    NSError* error;
    NSString* xhtml = [[CTidy tidy] tidyHTMLString:html
                                          encoding:@"UTF8"
                                             error:&error];
#if SF_DEBUG
    NSLog(@"xhtml:%@",xhtml);
#endif
    
    // 1
    NSData *htmlData = [xhtml dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2
    TFHpple *parser = [TFHpple hppleWithHTMLData:htmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//*";
    NSArray *elemArr = [parser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    NSMutableString *enml = [NSMutableString new];
    [enml appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"];
    [enml appendFormat:@"<en-note>"];
    
    int num = [elemArr count];
    for (int i = 0; i < num; i++) {
        TFHppleElement* element = [elemArr objectAtIndex:i];
#if SF_DEBUG
        NSLog(@"element tag name(%d):%@",i,element.tagName);
#endif
        [self travelHtmlNode:element withENML:enml withDumpedDict:dumpedDict];
    }
    
    [enml appendFormat:@"</en-note>"];
    
    return enml;
}

- (void)travelHtmlNode:(TFHppleElement*)element withENML:(NSMutableString*)enml withDumpedDict:(NSMutableDictionary*)dumpedDict {
    if ([element.tagName isEqualToString:@"p"]) {
        NSArray* arr = [element children];
        [enml appendFormat:@"<p>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</p>"];
    }
    else if ([element.tagName isEqualToString:@"br"]) {
#if SF_DEBUG
        NSLog(@"    br:%@",[[element firstChild] content]);
#endif
        [enml appendFormat:@"<br></br>"];
    }
    else if ([element.tagName isEqualToString:@"strong"]) {
#if SF_DEBUG
        NSLog(@"    strong:%@",[[element firstChild] content]);
#endif
        [enml appendFormat:@"<strong>"];
        NSArray* arr = [element children];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</strong>"];
    }
    else if ([element.tagName isEqualToString:@"h1"]) {
#if SF_DEBUG
        NSLog(@"    h1:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h1>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h1>"];
    }
    else if ([element.tagName isEqualToString:@"h2"]) {
#if SF_DEBUG
        NSLog(@"    h2:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h2>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h2>"];
    }
    else if ([element.tagName isEqualToString:@"h3"]) {
#if SF_DEBUG
        NSLog(@"    h3:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h3>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h3>"];
    }
    else if ([element.tagName isEqualToString:@"h4"]) {
#if SF_DEBUG
        NSLog(@"    h4:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h4>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h4>"];
    }
    else if ([element.tagName isEqualToString:@"h5"]) {
#if SF_DEBUG
        NSLog(@"    h5:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h5>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h5>"];
    }
    else if ([element.tagName isEqualToString:@"h6"]) {
#if SF_DEBUG
        NSLog(@"    h6:%@",[[element firstChild] content]);
#endif
        NSArray* arr = [element children];
        [enml appendFormat:@"<h6>"];
        for ( TFHppleElement *subElem in arr ) {
            [self travelHtmlNode:subElem withENML:enml withDumpedDict:dumpedDict];
        }
        [enml appendFormat:@"</h6>"];
    }
    else {
        [self travelHtmlLeaf:element withENML:enml withDumpedDict:dumpedDict];
    }
}

- (void)travelHtmlLeaf:(TFHppleElement*)element withENML:(NSMutableString*)enml withDumpedDict:(NSMutableDictionary*)dict {
    if ([element.tagName isEqualToString:@"a"]) {
#if SF_DEBUG
        NSLog(@"    href:%@",[element objectForKey:@"href"]);
        NSLog(@"    text:%@",[[element firstChild] content]);
#endif
        NSString* lnk = [[element objectForKey:@"href"] stringByEncodingHTMLEntities];
        
        if (!lnk||[dict objectForKey:lnk]||[lnk rangeOfString:@"http"].location==NSNotFound) {
            return;
        }
        
        if ( [[element firstChild] content] ) {
            [enml appendFormat:@"<a href=\"%@\" target=\"_blank\">%@</a>",lnk,[[element firstChild] content]];
        }
        else {
            [enml appendFormat:@"<a href=\"%@\" target=\"_blank\"></a>",lnk];
        }
        [dict setObject:lnk forKey:lnk];
    }
    else if ([element.tagName isEqualToString:@"img"]) {
#if SF_DEBUG
        NSLog(@"    src:%@",[element objectForKey:@"src"]);
        NSLog(@"    alt:%@",[element objectForKey:@"alt"]);
#endif
        NSString* src = [[element objectForKey:@"src"] stringByEncodingHTMLEntities];
        
        if (!src||[dict objectForKey:src]||[src rangeOfString:@"http"].location==NSNotFound) {
            return;
        }
        
        if ( [element objectForKey:@"alt"] ) {
            [enml appendFormat:@"<img src=\"%@\" alt=\"%@\"></img>",src,[element objectForKey:@"alt"]];
        }
        else {
            [enml appendFormat:@"<img src=\"%@\"></img>",src];
        }
        [dict setObject:src forKey:src];
    }
    else if ([element.tagName isEqualToString:@"text"]) {
#if SF_DEBUG
        NSLog(@"    text:%@",[element content]);
#endif
        NSString* text = [element content];
        if (!text || [dict objectForKey:text]) {
            return;
        }
        [enml appendFormat:@"%@",text];
        [dict setObject:text forKey:text];
    }
}

@end
