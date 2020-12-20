import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewSwapItemComponent } from './view-swap-item.component';

describe('ViewSwapItemComponent', () => {
  let component: ViewSwapItemComponent;
  let fixture: ComponentFixture<ViewSwapItemComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ViewSwapItemComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ViewSwapItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
