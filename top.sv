`include "APB.sv"
`include "apb_if.sv"
module top();
import apb_package::*;
logic pclk;
logic presetn;
initial begin
pclk=0;
end
initial begin
forever #10 pclk=~pclk;
end
initial begin
presetn=0;
repeat(2)@(posedge pclk);
presetn=1;
end
apb_if intrf(pclk,presetn);
APB slave(.PCLK(intrf.pclk),.PRESETn(intrf.presetn),.PADDR(intrf.paddr),.PSEL(intrf.psel),.PENABLE(intrf.penable),.PWRITE(intrf.pwrite),.PWDATA(intrf.pwdata),.PSTRB(intrf.pstrb),.PRDATA(intrf.prdata),.PREADY(intrf.pready),.PSLVERR(intrf.pslverr));
test_regression tb_regression=new(intrf.DRV,intrf.MON,intrf.REF);
initial begin
tb_regression.run();
$finish();
end
endmodule
