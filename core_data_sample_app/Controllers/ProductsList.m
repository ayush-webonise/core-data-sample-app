//
//  ProductsList.m
//  core_data_sample_app
//
//  Created by webonise on 26/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

#import "ProductsList.h"

@implementation ProductsList
@synthesize setButtonTitle,nSManagedObject;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [textFieldProductName setText:[nSManagedObject valueForKey:ATTRIBUTE_NAME]];
    [textFieldProductPrice setText:[nSManagedObject valueForKey:ATTRIBUTE_PRICE]];
    [textFieldProductCategory setText:[nSManagedObject valueForKey:ATTRIBUTE_CATEGORY]];
    [textFieldManufactureDate setText:[nSManagedObject valueForKey:ATTRIBUTE_MANUFACTURE_DATE]];
    if([self updateFlag]){
        [buttonAddPressed setTitle:setButtonTitle forState:UIControlStateNormal];
    }
}

/** This function checks for validations whether the user has added only whitespaces in the text field
* \returns Returns YES if the names and prices are added correctly else returns NO
*/
-(BOOL) isValid:(NSString*)isValidString
{
    if([isValidString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/** This function checks for validations whether the user has added only whitespaces in the text field
 * \returns Returns YES if the names and prices are added correctly else returns NO
 */
- (void)checkValidation
{
    if(![self isValid:textFieldProductName.text])
    {
        [textFieldProductName becomeFirstResponder];
    }
    else if(![self isValid:textFieldProductPrice.text])
    {
        [textFieldProductPrice becomeFirstResponder];
    }
    else if (![self isValid:textFieldProductCategory.text])
    {
        [textFieldProductCategory becomeFirstResponder];
    }
    else if (![self isValid:textFieldManufactureDate.text])
    {
        [textFieldManufactureDate becomeFirstResponder];
    }
    else{
        [self addProduct];
    }
}

/** Function clears all the three text fields upon calling
 * \returns Returns nothing
 */
-(void) clearTextFields{
    textFieldProductName.text= @"";
    textFieldProductPrice.text = @"";
    textFieldProductCategory.text = @"";
    textFieldManufactureDate.text = @"";
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

/** This function adds product in the database. It checks for the object and updates it, else it inserts it into the database
* \returns Nothing
*/
-(void)addProduct
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if(self.nSManagedObject)
    {
        [nSManagedObject setValue:self->textFieldProductName.text forKey:ATTRIBUTE_NAME];
        [nSManagedObject setValue:self->textFieldProductPrice.text forKey:ATTRIBUTE_PRICE];
        [nSManagedObject setValue:self->textFieldManufactureDate.text forKey:ATTRIBUTE_MANUFACTURE_DATE];
        [nSManagedObject setValue:self->textFieldProductCategory.text forKey:ATTRIBUTE_CATEGORY];

    }
    else{
        NSManagedObject *newProduct = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_PRODUCTS inManagedObjectContext:context];
        [newProduct setValue:self->textFieldProductName.text forKey:ATTRIBUTE_NAME];
        [newProduct setValue:self->textFieldProductPrice.text forKey:ATTRIBUTE_PRICE];
        [newProduct setValue:self->textFieldManufactureDate.text forKey:ATTRIBUTE_MANUFACTURE_DATE];
        [newProduct setValue:self->textFieldProductCategory.text forKey:ATTRIBUTE_CATEGORY];
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self clearTextFields];
    [textFieldProductName becomeFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

/** It performs action when ADD button is pressed. Calls checkValidation method and UIAlertView
 * \param sender ID of ADD button
 */

- (IBAction)buttonAddPressed:(id)sender {
    [self checkValidation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
