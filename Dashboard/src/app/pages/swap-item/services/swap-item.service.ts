import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { SwapItemDetailsResponse } from '../entity/swap-item-details-response';
import { SwapItemsResponse } from '../entity/swap-item-response';

@Injectable({
  providedIn: 'root'
})
export class SwapItemService {

  constructor(private httpClient: HttpClient) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allSwapItems(): Observable<SwapItemsResponse> {
    return this.httpClient.get<SwapItemsResponse>(
      AdminConfig.swapItemAPI
    ).pipe(catchError(SwapItemService.errorHandler));
  }

  getSwapItem(swapItemId: number): Observable<SwapItemDetailsResponse> {
    return this.httpClient.get<SwapItemDetailsResponse>(
      `${AdminConfig.getSwapItemAPI}/${swapItemId}`
    ).pipe(catchError(SwapItemService.errorHandler));
  }

  deleteSwapItem(swapItemId: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.swapItemAPI}/${swapItemId}`
    ).pipe(catchError(SwapItemService.errorHandler));
  }



}
