//
//  Products.h
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Products : NSObject
@property(readwrite)NSString *productName;
@property(readwrite)NSString *productPrice;
@property(readwrite)NSString *productCategory;
@property(readwrite)NSString *manufactureDate;
@end
