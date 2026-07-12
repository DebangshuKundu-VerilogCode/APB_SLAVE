class apb_driver;
apb_transaction_ apb_drv;
mailbox#(apb_transaction_)mbx_gd;
mailbox#(apb_transaction_)mbx_dr;
virtual apb_if.DRV vif;
covergroup cg_type;
option.per_instance=1;
type_of:coverpoint apb_drv.pwrite {
bins wr={1};
bins rd={0};
}
endgroup
covergroup cg_phase;
option.per_instance=1;
addr:coverpoint apb_drv.paddr {
bins low={0};
bins high={`DATA_DEPTH-1};
bins mid={[1:`DATA_DEPTH-2]};
bins out={[`DATA_DEPTH:(2**`ADDR_WIDTH)-1]};
}
endgroup
covergroup cg_addr_type;
option.per_instance=1;
type_of:coverpoint apb_drv.pwrite {
bins wr={1};
bins rd={0};
}
addr:coverpoint apb_drv.paddr {
bins low={0};
bins high={`DATA_DEPTH-1};
bins mid={[1:`DATA_DEPTH-2]};
bins out={[`DATA_DEPTH:(2**`ADDR_WIDTH)-1]};
}
typeofxaddr:cross type_of,addr;
endgroup
covergroup cg_pstrb;
option.per_instance=1;
strb:coverpoint apb_drv.pstrb {
bins all_zero={0};
bins all_one={(1<<(`DATA_WIDTH/8))-1};
bins others={[1:(1<<(`DATA_WIDTH/8))-2]};
}
endgroup
function new(mailbox#(apb_transaction_)mbx_gd,mailbox#(apb_transaction_)mbx_dr,virtual apb_if.DRV vif);
this.mbx_gd=mbx_gd;
this.mbx_dr=mbx_dr;
this.vif=vif;
cg_type=new();
cg_phase=new();
cg_addr_type=new();
cg_pstrb=new();
endfunction
task start();
if(vif==null)begin
$display("ERROR: vif is NULL");
$finish;
end
repeat(3)@(vif.drv_cb);
for(int i=0;i<`num_transactions;i++)
begin
apb_drv=new();
mbx_gd.get(apb_drv);
if(vif.drv_cb.presetn==0) begin
apb_drv.pwrite=0;
apb_drv.penable=0;
apb_drv.pwdata=0;
apb_drv.paddr=0;
apb_drv.psel=0;
apb_drv.pstrb=0;
end
cg_type.sample();
cg_phase.sample();
cg_addr_type.sample();
cg_pstrb.sample();
@(vif.drv_cb);
vif.drv_cb.pwrite<=apb_drv.pwrite;
vif.drv_cb.penable<=apb_drv.penable;
vif.drv_cb.pwdata<=apb_drv.pwdata;
vif.drv_cb.paddr<=apb_drv.paddr;
vif.drv_cb.psel<=apb_drv.psel;
vif.drv_cb.pstrb<=apb_drv.pstrb;
$display("DRIVER DRIVING DATA pwrite=%0b,penable=%0b,pwdata=%0h,paddr=%0h,psel=%0b",apb_drv.pwrite,apb_drv.penable,apb_drv.pwdata,apb_drv.paddr,apb_drv.psel);
mbx_dr.put(apb_drv);
end
endtask
endclass
