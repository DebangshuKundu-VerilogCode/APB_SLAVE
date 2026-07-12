class apb_transaction;
rand logic pwrite;
rand logic penable;
rand logic[`DATA_WIDTH-1:0] pwdata;
rand logic[ADDR_WIDTH-1:0] paddr;
rand logic psel;
rand logic[(`DATA_WIDTH/8)-1:0] pstrb;
logic pready;
logic [7:0] prdata;
logic pslverr;
constraint x{{psel,penable,pwrite} inside {[4:7]};}
virtual function apb_transaction copy();
copy=new();
copy.pwrite=this.pwrite;
copy.penable=this.penable;
copy.pwdata=this.pwdata;
copy.paddr=this.paddr;
copy.psel=this.psel;
copy.pstrb=this.pstrb;
return copy;
endfunction
endclass

class apb_write extends apb_transaction;
constraint wr{pwrite==1;}
virtual function apb_transaction copy();
apb_write copy1;
copy1=new();
copy1.pwrite=this.pwrite;
copy1.penable=this.penable;
copy1.pwdata=this.pwdata;
copy1.paddr=this.paddr;
copy1.psel=this.psel;
copy1.pstrb=this.pstrb;
return copy1;
endfunction
endclass

class apb_read extends apb_transaction;
constraint rd{pwrite==0;}
virtual function apb_transaction copy();
apb_read copy2;
copy2=new();
copy2.pwrite=this.pwrite;
copy2.penable=this.penable;
copy2.pwdata=this.pwdata;
copy2.paddr=this.paddr;
copy2.psel=this.psel;
copy2.pstrb=this.pstrb;
return copy2;
endfunction
endclass

class apb_write_low_high extends apb_transaction;
constraint low_high_write{(pwrite==1)&&(paddr==0 || paddr==`DATA_DEPTH-1);}
virtual function apb_transaction copy();
apb_write_low_high copy3;
copy3=new();
copy3.pwrite=this.pwrite;
copy3.penable=this.penable;
copy3.pwdata=this.pwdata;
copy3.paddr=this.paddr;
copy3.psel=this.psel;
copy3.pstrb=this.pstrb;
return copy3;
endfunction
endclass

class apb_read_low_high extends apb_transaction;
constraint low_high_read{(pwrite==0)&&(paddr==0 || paddr==`DATA_DEPTH-1);}
virtual function apb_transaction copy();
apb_read_low_high copy4;
copy4=new();
copy4.pwrite=this.pwrite;
copy4.penable=this.penable;
copy4.pwdata=this.pwdata;
copy4.paddr=this.paddr;
copy4.psel=this.psel;
copy4.pstrb=this.pstrb;
return copy4;
endfunction
endclass

class apb_read_out_of_range extends apb_transaction;
constraint read_out{(pwrite==0)&&(paddr>(`DATA_DEPTH/2));}
virtual function apb_transaction copy();
apb_read_out_of_range copy5;
copy5=new();
copy5.pwrite=this.pwrite;
copy5.penable=this.penable;
copy5.pwdata=this.pwdata;
copy5.paddr=this.paddr;
copy5.psel=this.psel;
copy5.pstrb=this.pstrb;
return copy5;
endfunction
endclass

class apb_write_out_of_range extends apb_transaction;
constraint write_out{(pwrite==1)&&(paddr>(`DATA_DEPTH/2));}
virtual function apb_transaction copy();
apb_write_out_of_range copy6;
copy6=new();
copy6.pwrite=this.pwrite;
copy6.penable=this.penable;
copy6.pwdata=this.pwdata;
copy6.paddr=this.paddr;
copy6.psel=this.psel;
copy6.pstrb=this.pstrb;
return copy6;
endfunction
endclass

class strobe_all_one extends apb_transaction;
constraint all_one{pstrb==1;}
virtual function apb_transaction copy();
strobe_all_one copy7;
copy7=new();
copy7.pwrite=this.pwrite;
copy7.penable=this.penable;
copy7.pwdata=this.pwdata;
copy7.paddr=this.paddr;
copy7.psel=this.psel;
copy7.pstrb=this.pstrb;
return copy7;
endfunction
endclass

class strobe_all_zero extends apb_transaction;
constraint all_one{pstrb==0;}
virtual function apb_transaction copy();
strobe_all_zero copy8;
copy8=new();
copy8.pwrite=this.pwrite;
copy8.penable=this.penable;
copy8.pwdata=this.pwdata;
copy8.paddr=this.paddr;
copy8.psel=this.psel;
copy8.pstrb=this.pstrb;
return copy8;
endfunction
endclass
