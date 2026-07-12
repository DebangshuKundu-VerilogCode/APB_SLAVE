class apb_monitor;
apb_transaction_ apb_mon;
mailbox#(apb_transaction_)mbx_ms;
virtual apb_if.MON vif;
function new(mailbox#(apb_transaction_)mbx_ms,virtual apb_if.MON vif);
this.mbx_ms=mbx_ms;
this.vif=vif;
endfunction
task start();
repeat(2)@(vif.mon_cb);
for(int i=0;i<`num_transactions;i++) begin
apb_mon=new();
@(vif.mon_cb);
apb_mon.pready=vif.mon_cb.pready;
apb_mon.prdata=vif.mon_cb.prdata;
apb_mon.pslverr=vif.mon_cb.pslverr;
apb_mon.paddr=vif.mon_cb.paddr;
apb_mon.pwrite=vif.mon_cb.pwrite;
apb_mon.psel=vif.mon_cb.psel;
apb_mon.penable=vif.mon_cb.penable;
$display("MONITOR PASSING DATA TO SCOREBOARD pready=%0b,prdata=%0h,pslverr=%0b,paddr=%0h",apb_mon.pready,apb_mon.prdata,apb_mon.pslverr,apb_mon.paddr);
mbx_ms.put(apb_mon);
end
endtask
endclass
