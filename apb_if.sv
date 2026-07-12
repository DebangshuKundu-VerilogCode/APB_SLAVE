`include "defines.svh"
interface apb_if(input logic pclk,input logic presetn);
logic pwrite;
logic penable;
logic [`DATA_WIDTH-1:0] pwdata;
logic [`ADDR_WIDTH-1:0] paddr;
logic psel;
logic [(`DATA_WIDTH/8)-1:0] pstrb;
logic pready;
logic [`DATA_WIDTH-1:0] prdata;
logic pslverr;
property p_reset_pslverr;
@(posedge pclk) (!presetn) |-> (pslverr==0);
endproperty
assert property(p_reset_pslverr);
property p_pready_high;
@(posedge pclk) pready;
endproperty
assert property(p_pready_high);
property p_no_penable_without_psel;
@(posedge pclk) disable iff(!presetn)
!psel |-> !penable;
endproperty
assert property(p_no_penable_without_psel);
property p_pslverr_out_of_range;
@(posedge pclk) disable iff(!presetn)
(psel && penable && (paddr>=`DATA_DEPTH)) |-> pslverr;
endproperty
assert property(p_pslverr_out_of_range);
property p_no_pslverr_in_range;
@(posedge pclk) disable iff(!presetn)
(psel && penable && (paddr<`DATA_DEPTH)) |-> !pslverr;
endproperty
assert property(p_no_pslverr_in_range);
property p_pslverr_implies_psel;
@(posedge pclk) disable iff(!presetn)
pslverr |-> psel;
endproperty
assert property(p_pslverr_implies_psel);
property p_no_psel_no_pslverr;
@(posedge pclk) disable iff(!presetn)
!psel |-> !pslverr;
endproperty
assert property(p_no_psel_no_pslverr);
clocking drv_cb@(posedge pclk);
default input #1 output #1;
input presetn;
output pwrite;
output penable;
output pwdata;
output paddr;
output psel;
output pstrb;
endclocking
clocking mon_cb@(posedge pclk);
default input #1 output #1;
input pready;
input prdata;
input pslverr;
input paddr;
input pwrite;
input psel;
input penable;
endclocking
clocking ref_cb@(posedge pclk);
default input #1 output #1;
endclocking
modport DRV(clocking drv_cb);
modport MON(clocking mon_cb);
modport REF(clocking ref_cb);
endinterface
