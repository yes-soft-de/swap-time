import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { SwapsOperationRoutingModule } from './swaps-operation-routing.module';

import { SwapsOperationComponent } from './swaps-operation.component';
import { ListSwapOperationsComponent } from './components/list-swap-operations/list-swap-operations.component';


@NgModule({
  declarations: [SwapsOperationComponent, ListSwapOperationsComponent],
  imports: [
    ThemeModule,
    SwapsOperationRoutingModule
  ]
})
export class SwapsOperationModule { }
