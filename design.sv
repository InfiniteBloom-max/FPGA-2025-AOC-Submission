module dial_rotator (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,
    input  wire        direction,    // 0 = Left, 1 = Right
    input  wire [6:0]  distance,
    output reg  [6:0]  dial_pos,
    output reg  [15:0] zero_count,
    output reg         busy
);

    reg [6:0] steps_left;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dial_pos   <= 7'd50;
            zero_count <= 16'd0;
            steps_left <= 7'd0;
            busy       <= 1'b0;
        end else begin

            if (start && !busy) begin
                steps_left <= distance;
                busy       <= (distance != 0);
            end

            if (busy) begin
                if (direction == 1'b0) begin
                    if (dial_pos == 0)
                        dial_pos <= 7'd99;
                    else
                        dial_pos <= dial_pos - 1;
                end else begin
                    if (dial_pos == 7'd99)
                        dial_pos <= 7'd0;
                    else
                        dial_pos <= dial_pos + 1;
                end

                steps_left <= steps_left - 1;

                if ((dial_pos == 1 && direction == 1'b0) ||
                    (dial_pos == 7'd99 && direction == 1'b1))
                    zero_count <= zero_count + 1;

                if (steps_left == 1)
                    busy <= 1'b0;
            end
        end
    end
endmodule
