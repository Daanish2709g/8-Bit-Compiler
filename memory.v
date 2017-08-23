module memory(
  input wire clk,
  input wire [7:0] addr,
  input wire we,               // Write Enable (write if we is high else read)
  input wire oe,               // Enable Output
  inout wire [7:0] data
);

  reg [7:0] mem [0:255];
  reg [7:0] buffer;

  initial begin
    $readmemh("memory.list", mem);
  end

  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data;
      $display("Memory: set [0x%h] => 0x%h (%d)", addr, data, data);
    end else begin
      buffer <= mem[addr];
      $display("Memory: read [0x%h] = 0x%h (%d)", addr, mem[addr], mem[addr]);
    end
  end

  assign data = (oe && !we) ? buffer : 8'bz;

endmodule
