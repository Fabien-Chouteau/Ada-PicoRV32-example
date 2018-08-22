module neopixel(clk_16MHz, dout, data_in, start_tx, busy);

    parameter nbr_pixels = 1;

    input wire clk_16MHz;
    output reg dout;
    input wire [nbr_pixels*24-1:0] data_in;
    input wire start_tx;
    output wire busy;

    wire [9:0] T1H = 10'd13;  // Hi signal time for 1
    wire [9:0] T0H = 10'd6;   // Hi signal time for 0
    wire [9:0] TF  = 10'd20;  // Entire pulse width time

    reg [7:0] data_index = 0;

    reg [25:0] counter = 0;

    parameter idle = 2'b00;
    parameter tx_in_progress = 2'b01;
    parameter ending = 2'b10;

    reg [1:0] state = idle;

    initial begin
       dout <= 0;
    end

    assign busy = (state == tx_in_progress);

    always @(posedge clk_16MHz) begin
      case (state)
        idle : begin
          if (start_tx == 1) begin
             state <= tx_in_progress;
             counter <= 0;
             data_index <= (24 * nbr_pixels) - 1;
          end
        end

        tx_in_progress: begin

          if (data_in[data_index] == 1 ? counter <= T1H : counter <= T0H) begin
             dout <= 1;
          end else begin
             dout <= 0;
          end

           if (counter == TF) begin
               counter <= 0;
               if (data_index == 0) begin
                   state <= ending;
               end else begin
                   data_index <= data_index - 1;
               end
           end else begin
               counter <= counter + 1;
           end
         end
        ending: begin
          if (start_tx == 0) begin
             state <= idle;
          end
        end

      endcase
   end

endmodule
