class apb_generator;
apb_transaction apb;
mailbox#(apb_transaction) mbx_gd;
function new(mailbox#(apb_transaction) mbx_gd);
this.mbx_gd=mbx_gd;
apb=new();
endfunction
task start();
repeat(`num_transactions)begin
assert(apb.randomize());
mbx_gd.put(apb.copy());
$display("GENERATOR:pwrite=%0b,penable=%0b,pwdata=%0h,paddr=%0h,psel=%0b,pstrb=%0d",apb.pwrite,apb.penable,apb.pwdata,apb.paddr,apb.psel,apb.pstrb);
end
endtask
endclass
