
module dataMemory(readData,address,writeData,memRead,memWrite,HAL);

input[31:0]address; // kant 5
input [31:0]writeData;
input memRead,memWrite,HAL  ; 
output reg [31:0] readData;
integer file ;
integer i;

reg [31:0]memory[0:8191];


/*initial
begin
    // Loading The Memory
$readmemb ("C:\\Users\\Mohammed Emad\\Desktop\\MIPS project\\m.txt", memory);  
   
end */



always @(address) 

begin

if(memRead == 0 && memWrite == 1)
begin 
if(HAL != 1)
begin
memory[address/4] <= writeData;  // note dividing by 4
end
else if(HAL)
begin
if((address/4)%4 == 0)memory[address/4][7:0] <= writeData;
else if((address/4)%4 == 1)memory[(address-1)/4][15:8] <= writeData;
else if((address/4)%4 == 2)memory[(address-2)/4][23:16] <= writeData;
else if((address/4)%4 == 3)memory[(address-3)/4][31:24] <= writeData;
end
end

else if(memRead == 1 && memWrite == 0)
begin
if(HAL !=1)
begin
readData = memory[address/4];   // note dividing by 4
end
else if(HAL)
begin
if((address/4)%4 == 0)readData=memory[address/4][7:0];
else if((address/4)%4 == 1)readData=memory[(address-1)/4][15:8];
else if((address/4)%4 == 2)readData=memory[(address-2)/4][23:16];
else if((address/4)%4 == 3)readData=memory[(address-3)/4][31:24];
end
end

else 
begin

readData = 32'hxxxxxxxx;

end

file = $fopen("C:\\Users\\Mohammed Emad\\Desktop\\MIPS project\\Printing\\out_dm.txt.txt","w");
for (i = 0; i<32; i=i+1)
begin
//@(posedge clk);
$fwrite(file,"%b\n",memory[i]);
end
$fclose(file);

end


endmodule
