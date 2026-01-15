`timescale 1ns/1ps

module tb_dial_rotator;

    reg clk;
    reg reset;
    reg start;
    reg direction;
    reg [6:0] distance;

    wire [6:0] dial_pos;
    wire [15:0] zero_count;
    wire busy;

    dial_rotator dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .direction(direction),
        .distance(distance),
        .dial_pos(dial_pos),
        .zero_count(zero_count),
        .busy(busy)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Init
        reset = 1;
        start = 0;
        direction = 0;
        distance = 0;

        #20 reset = 0;

        // ---- R10 ----
        direction = 1;
        distance  = 10;
        start     = 1;
        #10 start = 0;
        wait (!busy);

        // ---- L60 ----
        direction = 0;
        distance  = 60;
        start     = 1;
        #10 start = 0;
        wait (!busy);

        // ---- R100 ----
        direction = 1;
        distance  = 100;
        start     = 1;
        #10 start = 0;
        wait (!busy);

        #20;
        $display("FINAL ZERO COUNT = %d", zero_count);
        $finish;
    end

    initial begin
        $monitor(
            "t=%0t pos=%d busy=%b zero_count=%d",
            $time, dial_pos, busy, zero_count
        );
    end

endmodule
