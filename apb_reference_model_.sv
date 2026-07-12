class apb_reference_model_;
apb_transaction_ apb_ref;
mailbox#(apb_transaction_)mbx_dr;
mailbox#(apb_transaction_)mbx_rs;
virtual apb_if.REF vif;
logic[`DATA_WIDTH-1:0] mem[`DATA_DEPTH-1:0];
function new(mailbox#(apb_transaction_)mbx_dr,mailbox#(apb_transaction_)mbx_rs,virtual apb_if.REF vif);
this.mbx_dr=mbx_dr;
this.mbx_rs=mbx_rs;
this.vif=vif;
for(int j=0;j<`DATA_DEPTH;j++) mem[j]=0;
endfunction
task start();
int num_bytes;
int k;
for(int i=0;i<`num_transactions;i++)begin
apb_ref=new();
mbx_dr.get(apb_ref);
@(vif.ref_cb);
if((apb_ref.psel && !apb_ref.penable && !apb_ref.pwrite)||(apb_ref.psel && !apb_ref.penable && apb_ref.pwrite))
begin
apb_ref.pready=0;
apb_ref.pslverr=0;
apb_ref.prdata=0;
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr);
end
else if(apb_ref.psel && apb_ref.penable && !apb_ref.pwrite)
begin
if(apb_ref.paddr>=`DATA_DEPTH) begin
apb_ref.pready=1;
apb_ref.pslverr=1;
apb_ref.prdata='1;
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr);
end
else begin
apb_ref.pready=1;
apb_ref.pslverr=0;
apb_ref.prdata=mem[apb_ref.paddr];
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b,data out=%0h",apb_ref.pready,apb_ref.pslverr,apb_ref.prdata);
end
end
else if(apb_ref.psel && apb_ref.penable && apb_ref.pwrite) begin
apb_ref.prdata=0;
if(apb_ref.paddr>=`DATA_DEPTH) begin
apb_ref.pready=1;
apb_ref.pslverr=1;
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr);
end
else begin
apb_ref.pready=1;
apb_ref.pslverr=0;
num_bytes=(`DATA_WIDTH)/8;
for(k=0;k<num_bytes;k++) begin
if(apb_ref.pstrb[k])
mem[apb_ref.paddr][k*8 +: 8]=apb_ref.pwdata[k*8 +: 8];
end
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b,data written=%0h",apb_ref.pready,apb_ref.pslverr,apb_ref.pwdata);
end
end
else begin
apb_ref.pready=0;
apb_ref.pslverr=0;
apb_ref.prdata=0;
$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr);
end
mbx_rs.put(apb_ref);
end
endtask
endclass
