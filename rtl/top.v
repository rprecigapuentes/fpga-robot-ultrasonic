module top (
    input wire clk,
    input wire on,
    input wire echo,
    input wire LF,
    input wire RF,
    input wire LB,
    input wire RB,
    output wire trigger,
    output wire AA,
    output wire AB,
    output wire BA,
    output wire BB,
    output wire lLF,
    output wire lRF,
    output wire lLB,
    output wire lRB,
    output wire lcerca 
);

wire cerca;
reg cercaAct;
reg cercaPrev;
wire [3:0] status;
reg ultrainit;
wire [15:0] dist;
reg [21:0] cont; 

assign lLF = LF;
assign lRF = RF;
assign lLB = LB;
assign lRB = RB;
assign lcerca = cerca;

maquinaestado(
    .on(on),
    .LF(~LF), 
    .RF(~RF), 
    .LB(~LB), 
    .RB(~RB), 
    .U(cerca), 
    .clk(clk), 
    .estado(status[3:0])
);

ultra(
        .clk(clk),
        .init(ultrainit),
        .echo(echo),
        .trigger(trigger),
        .done(),
        .dist(dist)
    );

pwm(
    .status(status[1:0]),
    .aa(AA), 
    .ab(AB), 
    .ba(BA), 
    .bb(BB)
);
assign cerca = cercaAct & cercaPrev;
always @(posedge clk)begin
    cont<=cont+1'b1;
    if(cont == 22'd3700000)begin
    cercaPrev <= cercaAct;
    ultrainit <= 1'b1;
    cont <= 1'b0;
    if(dist < 10'd1000) cercaAct <= 1'b1;
    else cercaAct <= 1'b0;
    end else begin 
        ultrainit <= 0;
    end
    
    
end

endmodule