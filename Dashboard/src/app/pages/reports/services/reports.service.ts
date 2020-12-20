import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { ReportsResponse } from '../entity/reportsResponse';

@Injectable({
  providedIn: 'root'
})
export class ReportsService {

  constructor(private httpClient: HttpClient) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allReports(): Observable<ReportsResponse> {
    return this.httpClient.get<ReportsResponse>(
      AdminConfig.reportAPI
    ).pipe(catchError(ReportsService.errorHandler));
  }

  deleteReport(reportId: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.reportAPI}/${reportId}`
    ).pipe(catchError(ReportsService.errorHandler));
  }
}
