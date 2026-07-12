class apb_reference_model.sv;
apb_transaction apb_ref;
mailbox#(apb_transaction)mbx_dr;
mailbox#(apb_transaction)mbx_rs;
virtual apb_if.REF vif;
reg[7:0]mem[7:0];
function new(mailox#(apb_transaction)mbx_dr,mailbox#(apb_transaction)mbx_rs,virtual apb_if.REF vif);
this.mbx_dr=mbx_dr;
this.mbx_rs=mbx_rs;
this.vif=vif;
endfunction
task start();
for(int i=0;i<`num_transactions;i++)begin
				apb_ref=new();
				mbx_dr.get(apb_ref);
				repeat(1)@(vif.ref_cb)begin
				if((apb_ref.psel && !apb_ref.penable && !apb_ref.pwrite)||(apb_ref.psel && !apb_ref.penable && apb_ref.pwrite))
					begin
								apb_ref.pready=0;
								apb_ref.pslverr=0;
								$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr,$time);
					end
				else if(apb_ref.psel && apb_ref.penable && !apb_ref.pwrite)
							begin
							  if(apb_ref.paddr>63) begin
												apb_ref.pready=1;
												apb_ref.pslverr=1;
												$display("REF MODEL DATA IN pready=%0b,pslverr=%0b",apb_ref.pready,apb_ref.pslverr,$time);
												end
								else begin
												apb_ref.pready=1;
												apb_ref.pslverr=1;
												apb_ref.prdata=mem[apb_ref.paddr];
												$display("REF MODEL DATA IN pready=%0b,pslverr=%0b,data out=%0h",apb_ref.pready,apb_ref.pslverr,apb_ref.prdata,$time);
												end
				end
				else if(apb_ref.psel && apb_ref.penable && apb_ref.pwrite) begin
								if(apb_ref.paddr>63) begin
												apb_ref.pready=1;
												apb_ref.pslverr=1;
												$display("REF MODEL DATA IN pready=%0b,pslverr=%    0b",apb_ref.pready,apb_ref.pslverr,$time);
												end
								else begin
												apb_ref.pready=1;
												 apb_ref.pslverr=1;
												 mem[apb_ref.paddr]=apb_ref.pwdata;
												 $display("REF MODEL DATA IN pready=%0b,pslverr=%    0b,data written=%0h",apb_ref.pready,apb_ref.pslverr,apb_ref.pwdata,$time);
                 end
				end
				else begin
								apb_ref.pready=0;
								apb_ref.pslverr=0;
								$display("REF MODEL DATA IN pready=%0b,pslverr=%    0b",apb_ref.pready,apb_ref.pslverr,$time);
								end
								mbx_rs.put(apb_ref);
								end
						end
         endtask
			endclass

