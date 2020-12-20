import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ListSwapOperationsComponent } from './list-swap-operations.component';

describe('ListSwapOperationsComponent', () => {
  let component: ListSwapOperationsComponent;
  let fixture: ComponentFixture<ListSwapOperationsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ListSwapOperationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListSwapOperationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
