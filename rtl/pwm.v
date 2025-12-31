module pwm (
    input wire [1:0] status,
    output  wire aa,
    output  wire ab,
    output  wire ba,
    output  wire bb
);


wire saa, sab, sba, sbb;

assign saa = status[0];
assign sab = (~status[0]) & status[1];
assign sba = status[1];
assign sbb = status[0] & (~status[1]);

assign aa = saa ? 1'b1 : 1'b0;
assign ab = sab ? 1'b1 : 1'b0;
assign ba = sba ? 1'b1 : 1'b0;
assign bb = sbb ? 1'b1 : 1'b0;

endmodule