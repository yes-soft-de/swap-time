import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { Swap } from '../../entity/swap';
import { SwapResponse } from '../../entity/swapResponse';
import { SwapOperationService } from '../../services/swap-operation.service';

@Component({
  selector: 'app-list-swap-operations',
  templateUrl: './list-swap-operations.component.html',
  styleUrls: ['./list-swap-operations.component.scss']
})
export class ListSwapOperationsComponent implements OnInit {
  
  swapOperations: Swap[];
  swapOperationsList: Swap[] = [];
  swapOperationsFilterList: Swap[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  suggestProgress = false;
  allSwapOperationsObservable: Subscription;
  

  constructor(
    private swapOperationService: SwapOperationService,
    private toaster: ToastrService
    ) { }

  ngOnInit() {
    this.getSwapOperations();
  }



  ngOnDestroy() {
    this.allSwapOperationsObservable.unsubscribe();
  }

  getSwapOperations() {
    // all Swap Operations
    this.allSwapOperationsObservable = this.swapOperationService.allSwapOperations().subscribe(
      (swapOperationsResponse: SwapResponse) => {
        if (swapOperationsResponse) {
          this.swapOperations = swapOperationsResponse.data;
          this.swapOperationsList = swapOperationsResponse.data;
        }
        console.log(swapOperationsResponse);
      }, 
      error1 => console.log('Error :', error1), 
      () => {
        this.swapOperationsFilterList = this.swapOperationsList;
      });


    this.config = {
      itemsPerPage: 10,
      currentPage: 1,
      totalItems: this.swapOperationsList.length
    };
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }


  // Delete The Swap Operations
  delete(swapOperationId: number) {
    if (confirm('Are You Sure You Want To Delete This Item')) {
      this.isDeleted = true;
      this.swapOperationService.deleteSwapOperation(swapOperationId).subscribe(
        data => {
          this.toaster.success('Swap Operation Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getSwapOperations();
        }
      );
    } else {
      return false;
    }
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.swapOperationsFilterList = [...this.swapOperationsList];
    } else {
      this.swapOperationsFilterList = [];
      this.swapOperationsFilterList = this.swapOperationsList.filter(res => {
        // Search In Name Column
        const status = res.status.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In Name Column
        const userOneName = res.userOneName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In userName Column
        const serTwoName = res.userTwoName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (status) {
          // display the Name Column
          return status;
        } else if (userOneName) {
          // display the Name Column
          return userOneName;
        } else if (serTwoName) {
          return serTwoName;
        }
      });
    }
  }
}