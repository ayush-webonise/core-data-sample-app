//
//  ProductsList.h
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Products.h"
#import "Constants.h"
#import <CoreData/CoreData.h>

@interface ProductsList : UIViewController{
    IBOutlet UITextField *textFieldProductName;
    IBOutlet UITextField *textFieldProductPrice;
    IBOutlet UITextField *textFieldProductCategory;
    IBOutlet UITextField *textFieldManufactureDate;
    IBOutlet UIButton *buttonAddPressed;
}
@property(readwrite) NSString *setButtonTitle;
@property(strong) NSManagedObject *nSManagedObject;
@property(readwrite) BOOL updateFlag;
@end
