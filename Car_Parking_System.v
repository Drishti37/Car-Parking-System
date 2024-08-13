`timescale 1ns / 1ps

module parking_system(
    input clk,
    input reset_n,
    input sensor_entrance,
    input sensor_exit,
    input [1:0] password,
    output wire GREEN_LED,
    output wire RED_LED
);

    parameter IDLE = 2'b00;
    parameter PASSWORD =2'b01;
    parameter WRONG_PASS = 2'b10;
    parameter PARK = 2'b11;
   
    reg [1:0] current_state, next_state;
    reg [6:0] count=7'b0000000;

    reg red_tmp, green_tmp;

    always @(posedge clk or negedge reset_n ) 
    begin
        if (~reset_n) 
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(current_state or sensor_entrance or sensor_exit or password) 
    begin
        case (current_state)
        
            IDLE: begin
                  green_tmp = 1'b0;
                  red_tmp = 1'b0;
                  if (count <= 7'b1100100)
                      begin
                      if(sensor_exit)
                         count=count-1;
                      if (sensor_entrance)
                         next_state = PASSWORD;
                      else
                         next_state = IDLE;
                      end
                  else
                      next_state = IDLE;
                  end

        PASSWORD: begin
                  if (password == 2'b11)
                      begin
                      green_tmp = 1'b1; 
                      red_tmp = 1'b0;
                      next_state = PARK;
                      end
                  else
                      next_state = WRONG_PASS;
                  end

      WRONG_PASS: begin
                  green_tmp = 1'b0;
                  red_tmp = 1'b1; 
                  if (password == 2'b11)
                      begin
                      green_tmp =1'b1; 
                      red_tmp = 1'b0;
                      next_state = PARK;
                      end
                  else
                      next_state = WRONG_PASS;
                  end

            PARK: begin
                  green_tmp =1'b0; 
                  red_tmp = 1'b0;
                  count=count+1;
                  next_state = IDLE;
                  end

         default: next_state = IDLE;
            
        endcase
        
    end

    assign RED_LED = red_tmp;
    assign GREEN_LED = green_tmp;
    
 endmodule
