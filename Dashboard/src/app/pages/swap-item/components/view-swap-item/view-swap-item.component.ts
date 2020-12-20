import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { SwapItemDetails } from '../../entity/swap-item-details';
import { SwapItemDetailsResponse } from '../../entity/swap-item-details-response';
import { SwapItemService } from '../../services/swap-item.service';

@Component({
  selector: 'app-view-swap-item',
  templateUrl: './view-swap-item.component.html',
  styleUrls: ['./view-swap-item.component.scss']
})
export class ViewSwapItemComponent implements OnInit {
  swapItemId: number;
  swapItemDetails: SwapItemDetails;

  constructor(
        private activateRoute: ActivatedRoute, 
        private swapItemService: SwapItemService) { }

  ngOnInit(): void {
    this.swapItemId = parseInt(this.activateRoute.snapshot.paramMap.get('id'));
    this.swapItemService.getSwapItem(this.swapItemId).subscribe(
      (swapDetails: SwapItemDetailsResponse) => {
        this.swapItemDetails = swapDetails.data;
        console.log(this.swapItemDetails);
      }, error => console.log(error)
    );
  }

}
