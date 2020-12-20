import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  loggedIn: boolean;
  constructor(private tokenService: TokenService, 
              private authService: AuthService,
              private router: Router) { }

  ngOnInit(): void {
    this.authService.authState.subscribe(
      loggedIn => this.loggedIn = loggedIn
    );
  }

  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.router.navigate(['/login']);
  }

}
