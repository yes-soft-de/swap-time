import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { SwapItemRoutingModule } from './swap-item-routing.module';
import { ListSwapItemsComponent } from './components/list-swap-items/list-swap-items.component';
import { ViewSwapItemComponent } from './components/view-swap-item/view-swap-item.component';
import { SwapItemComponent } from './swap-item.component';


@NgModule({
  declarations: [SwapItemComponent, ListSwapItemsComponent, ViewSwapItemComponent],
  imports: [
    ThemeModule,
    SwapItemRoutingModule
  ]
})
export class SwapItemModule { }
