class apb_environment;
virtual apb_if.DRV drv_vif;
virtual apb_if.MON mon_vif;
virtual apb_if.REF ref_vif;
mailbox#(apb_transaction_)mbx_gd;
mailbox#(apb_transaction_)mbx_dr;
mailbox#(apb_transaction_)mbx_rs;
mailbox#(apb_transaction_)mbx_ms;
apb_generator_ gen;
apb_driver drv;
apb_monitor mon;
apb_reference_model_ refm;
apb_scoreboard scb;
function new(virtual apb_if.DRV drv_if,virtual apb_if.MON mon_if,virtual apb_if.REF ref_if);
this.drv_vif=drv_if;
this.mon_vif=mon_if;
this.ref_vif=ref_if;
endfunction
task build();
mbx_gd=new();
mbx_dr=new();
mbx_rs=new();
mbx_ms=new();
gen=new(mbx_gd);
drv=new(mbx_gd,mbx_dr,drv_vif);
mon=new(mbx_ms,mon_vif);
refm=new(mbx_dr,mbx_rs,ref_vif);
scb=new(mbx_rs,mbx_ms);
endtask
task start();
fork
gen.start();
drv.start();
mon.start();
scb.start();
refm.start();
join
$display("TOTAL MATCH=%0d TOTAL MISMATCH=%0d",scb.MATCH,scb.MISMATCH);
endtask
endclass
