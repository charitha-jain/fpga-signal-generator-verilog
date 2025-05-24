Code:
module Basic_signal (
    input wire clk,
    input wire reset,
    input wire [1:0] wave_sel,
    output reg [7:0] wave_out
);

reg [23:0] clk_div;
wire slow_clk;
reg [7:0] triangle_counter;

always @(posedge clk or posedge reset) begin
    if (reset)
        clk_div <= 0;
    else
        clk_div <= clk_div + 1;
end

assign slow_clk = clk_div[23];

always @(posedge slow_clk or posedge reset) begin
    if (reset) begin
        wave_out <= 0;
        triangle_counter <= 0;
    end else begin
        case (wave_sel)
            2'b00: wave_out <= ~wave_out;
            2'b01: wave_out <= (wave_out == 8'b10101010) ? 8'b01010101 : 8'b10101010;
            2'b10: begin
                triangle_counter <= triangle_counter + 1;
                wave_out <= triangle_counter;
            end
            default: wave_out <= 8'b0;
        endcase
    end
end
endmodule
