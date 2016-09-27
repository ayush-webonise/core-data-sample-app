//
//  ViewController.h
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Products.h"
#import "ProductsList.h"
#import "DisplayProductsTableViewCell.h"
#import "Constants.h"

@interface AddProductsVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViewObject;
@property (readwrite) NSMutableArray *arrayProducts;

@end

