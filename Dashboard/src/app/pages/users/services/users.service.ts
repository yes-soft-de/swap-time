import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { UsersResponse } from '../entity/users-response';

@Injectable({
  providedIn: 'root'
})
export class UsersService {


  constructor(private httpClient: HttpClient) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allUsers(): Observable<UsersResponse> {
    return this.httpClient.get<UsersResponse>(
      AdminConfig.usersAPI
    ).pipe(catchError(UsersService.errorHandler));
  }

  // deleteUser(userId: number): Observable<any> {
  //   return this.httpClient.delete<any>(
  //     `${AdminConfig.usersAPI}/${userId}`
  //   ).pipe(catchError(UsersService.errorHandler));
  // }
}
