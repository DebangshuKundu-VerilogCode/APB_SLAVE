class apb_test;
virtual apb_if.DRV drv_vif;
virtual apb_if.MON mon_vif;
virtual apb_if.REF ref_vif;
apb_environment env;
function new(virtual apb_if.DRV drv_vif,virtual apb_if.MON mon_vif,virtual apb_if.REF ref_vif);
this.drv_vif=drv_vif;
this.mon_vif=mon_vif;
this.ref_vif=ref_vif;
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build();
env.start();
endtask
endclass

class test1 extends apb_test;
apb_write trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test2 extends apb_test;
apb_read trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test3 extends apb_test;
apb_write_low_high trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test4 extends apb_test;
apb_read_low_high trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test5 extends apb_test;
apb_read_out_of_range trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test6 extends apb_test;
apb_write_out_of_range trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test7 extends apb_test;
strobe_all_one trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test8 extends apb_test;
strobe_all_zero trans;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin
trans=new();
env.gen.apb=trans;
end
env.start;
endtask
endclass

class test_regression extends apb_test;
apb_transaction_ trans0;
apb_write trans1;
apb_read trans2;
apb_write_low_high trans3;
apb_read_low_high trans4;
apb_read_out_of_range trans5;
apb_write_out_of_range trans6;
strobe_all_one trans7;
strobe_all_zero trans8;
function new(virtual apb_if drv_vif,virtual apb_if mon_vif,virtual apb_if ref_vif);
super.new(drv_vif,mon_vif,ref_vif);
endfunction
task run();
env=new(drv_vif,mon_vif,ref_vif);
env.build;
begin 
trans0=new();
env.gen.apb=trans0;
end
env.start;
begin
trans1=new();
env.gen.apb=trans1;
end
env.start;
begin
trans2=new();
env.gen.apb=trans2;
end
env.start;
begin
trans3=new();
env.gen.apb=trans3;
end
env.start;
begin
trans4=new();
env.gen.apb=trans4;
end
env.start;
begin
trans5=new();
env.gen.apb=trans5;
end
env.start;
begin
trans6=new();
env.gen.apb=trans6;
end
env.start;
begin
trans7=new();
env.gen.apb=trans7;
end
env.start;
begin
trans8=new();
env.gen.apb=trans8;
end
env.start;
endtask
endclass
