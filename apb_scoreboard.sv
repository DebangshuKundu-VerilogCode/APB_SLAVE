class apb_scoreboard;
apb_transaction_ ref2sb_trans,mon2sb_trans;
mailbox#(apb_transaction_)mbx_rs;
mailbox#(apb_transaction_)mbx_ms;
logic[`DATA_WIDTH-1:0] ref_mem[logic[`ADDR_WIDTH-1:0]];
logic[`DATA_WIDTH-1:0] mon_mem[logic[`ADDR_WIDTH-1:0]];
int MATCH=0;
int MISMATCH=0;
function new(mailbox#(apb_transaction_)mbx_rs,mailbox#(apb_transaction_)mbx_ms);
this.mbx_rs=mbx_rs;
this.mbx_ms=mbx_ms;
endfunction
task start();
for(int i=0;i<`num_transactions;i++) begin
ref2sb_trans=new();
mon2sb_trans=new();
fork
begin
mbx_rs.get(ref2sb_trans);
ref_mem[ref2sb_trans.paddr]=ref2sb_trans.prdata;
$display("SCB REF prdata=%0h,address=%0h",ref_mem[ref2sb_trans.paddr],ref2sb_trans.paddr);
end
begin
mbx_ms.get(mon2sb_trans);
mon_mem[mon2sb_trans.paddr]=mon2sb_trans.prdata;
$display("SCB MON prdata=%0h,address=%0h",mon_mem[mon2sb_trans.paddr],mon2sb_trans.paddr);
end
join
compare_report();
end
endtask
task compare_report();
if(ref2sb_trans.prdata===mon2sb_trans.prdata) begin
$display("SCB ref_data_out=%0h,mon_data_out=%0h",ref2sb_trans.prdata,mon2sb_trans.prdata);
MATCH++;
$display("DATA MATCH SUCCESS COUNT %0d",MATCH);
end
else begin
$display("SCB ref_data_out=%0h,mon_data_out=%0h",ref2sb_trans.prdata,mon2sb_trans.prdata);
MISMATCH++;
$display("DATA MATCH FAIL COUNT %0d",MISMATCH);
end
endtask
endclass
