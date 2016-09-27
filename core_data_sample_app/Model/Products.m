//
//  Products.m
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

#import "Products.h"

@implementation Products
@synthesize productName, productPrice, productCategory, manufactureDate;

- (id)init
{
    self = [super init];
    productName = @"";
    productPrice = @"";
    productCategory = @"";
    manufactureDate = @"";
    return self;
}

@end