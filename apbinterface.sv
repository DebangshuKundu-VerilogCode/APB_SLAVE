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
