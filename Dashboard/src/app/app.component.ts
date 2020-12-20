import {Component} from '@angular/core';
import { Router } from '@angular/router';
import { TokenService } from './pages/admin-service/token/token.service';

@Component({
  selector: 'app-root',
  template: `
        <app-header></app-header>
  <router-outlet></router-outlet>`
})
export class AppComponent {
  
  title = 'Swap Dashboard';
  
  constructor() { }

  ngOnInit(): void {
 
  }

}
