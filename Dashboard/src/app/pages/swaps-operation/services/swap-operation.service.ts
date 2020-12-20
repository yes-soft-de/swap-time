import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { SwapResponse } from '../entity/swapResponse';

@Injectable({
  providedIn: 'root'
})
export class SwapOperationService {

  constructor(private httpClient: HttpClient) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allSwapOperations(): Observable<SwapResponse> {
    return this.httpClient.get<SwapResponse>(
      AdminConfig.swapOperationsAPI
    ).pipe(catchError(SwapOperationService.errorHandler));
  }

  deleteSwapOperation(swapOperationId: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.swapOperationsAPI}/${swapOperationId}`
    ).pipe(catchError(SwapOperationService.errorHandler));
  }
}
