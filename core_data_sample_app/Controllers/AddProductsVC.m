//
//  ViewController.m
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//
#import "AddProductsVC.h"
#import <CoreData/CoreData.h>

@implementation AddProductsVC
@synthesize tableViewObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProducts)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = item;
}

-(void) viewWillAppear:(BOOL)animated{
    // Fetch all the team members from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ENTITY_PRODUCTS];
    self.arrayProducts = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableViewObject reloadData];
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


-(void)addProducts {
    NSLog(@"added");
    ProductsList *productsList = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsList"];
    [self.navigationController pushViewController:productsList animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayProducts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"DisplayProductsTableViewCell";
    DisplayProductsTableViewCell *listProductsTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(listProductsTableViewCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        listProductsTableViewCell = [nib objectAtIndex:0] ;
    }
    NSManagedObject *productDetails =[self.arrayProducts objectAtIndex:indexPath.row];
    [listProductsTableViewCell.labelProductName setText:[productDetails valueForKey:ATTRIBUTE_NAME]];
    [listProductsTableViewCell.labelProductPrice setText:[productDetails valueForKey:ATTRIBUTE_PRICE]];
    [listProductsTableViewCell.labelManufactureDate setText:[productDetails valueForKey:ATTRIBUTE_MANUFACTURE_DATE]];
    return listProductsTableViewCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete team member from database
        [context deleteObject:[self.arrayProducts objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Cannot Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove team member from the list
        [self.arrayProducts removeObjectAtIndex:indexPath.row];
        [self.tableViewObject deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsList *productsList = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsList"];
    NSManagedObject *passDataObject = [self.arrayProducts objectAtIndex:indexPath.row];
    productsList.nSManagedObject = passDataObject;
    productsList.updateFlag = YES;
    productsList.setButtonTitle = UPDATE_TITLE;
    
    [self.navigationController pushViewController:productsList animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
