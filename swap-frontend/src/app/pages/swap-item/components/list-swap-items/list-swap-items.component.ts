import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { SwapItems } from '../../entity/swap-item';
import { SwapItemsResponse } from '../../entity/swap-item-response';
import { SwapItemService } from '../../services/swap-item.service';

@Component({
  selector: 'app-list-swap-items',
  templateUrl: './list-swap-items.component.html',
  styleUrls: ['./list-swap-items.component.scss']
})
export class ListSwapItemsComponent implements OnInit {

  
  swapItems: SwapItems[];
  swapItemsList: SwapItems[] = [];
  swapItemsFilterList: SwapItems[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  suggestProgress = false;
  allSwapItemsObservable: Subscription;
  

  constructor(
    private swapItemService: SwapItemService,
    private toaster: ToastrService
    ) { }

  ngOnInit() {
    this.getSwapItems();
  }



  ngOnDestroy() {
    this.allSwapItemsObservable.unsubscribe();
  }

  getSwapItems() {
    // all Swap Items
    this.allSwapItemsObservable = this.swapItemService.allSwapItems().subscribe(
      (swapItemsResponse: SwapItemsResponse) => {
        if (swapItemsResponse) {
          this.swapItems = swapItemsResponse.data;
          this.swapItemsList = swapItemsResponse.data;
        }
        console.log(swapItemsResponse);
      }, 
      error1 => console.log('Error :', error1), 
      () => {
        this.swapItemsFilterList = this.swapItemsList;
      });


    this.config = {
      itemsPerPage: 10,
      currentPage: 1,
      totalItems: this.swapItemsList.length
    };
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }


  // Delete The Swap Items
  delete(swapItemId: number) {
    if (confirm('Are You Sure You Want To Delete This Item')) {
      this.isDeleted = true;
      this.swapItemService.deleteSwapItem(swapItemId).subscribe(
        data => {
          this.toaster.success('Swap Item Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getSwapItems();
        }
      );
    } else {
      return false;
    }
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.swapItemsFilterList = [...this.swapItemsList];
    } else {
      this.swapItemsFilterList = [];
      this.swapItemsFilterList = this.swapItemsList.filter(res => {
        // Search In Name Column
        const nameResult = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In userName Column
        const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In categoryName Column
        const categoryName = res.category.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In platform Column
        const platform = res.platform.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (nameResult) {
          // display the Name Column
          return nameResult;
        } else if (userName) {
          return userName;
        } else if (categoryName) {
          return categoryName;
        } else if (platform) {
          return platform;
        }
      });
    }
  }
}