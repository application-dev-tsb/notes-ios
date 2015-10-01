# Table View
```objectivec
//minimum requirement for UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
```

## Header
```objectivec
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //get the first item of the section
    Item *item = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    return item.itemGroup;
}
```

[Notes: Core Data and NSFetchedResultsController](/CoreServices/CoreData.md)

**Sources:**
* [Apple Developer: Creating and Configuring a Table View](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html)
* [Apple Developer: UITableViewController](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UITableViewController_Class/index.html)
