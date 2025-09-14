module pipe(jump,clk,row,col,tens,units
    
);
    input clk,jump;
    output reg [7:0] row,col;
    output reg [7:0] tens,units;
    reg [7:0]row_p= 8'b11000111;
    reg [7:0]row_p0=8'b11000111;
    reg [7:0]row_p1=8'b10011111;
    reg [7:0]row_p2=8'b00111111;
    reg [7:0]row_p3=8'b11110001;
    reg [7:0]row_p4=8'b11111100;
    reg [7:0]row_p5=8'b00111111;
    reg [7:0]row_p6=8'b11111001;
    reg [7:0]row_p7=8'b10000001;
    reg [7:0]col_t=8'b10000000;
    reg [7:0]col_b = 8'b00000010;
    reg [7:0]row_b = 8'b00001000;
    reg [7:0]collison = 0;
    reg c;
    integer k=0;
    reg [7:0]score=0;
    reg [3:0]acc = 0;
    reg gameover = 0;
    reg jump_f=0 ;
    reg start = 0;
    reg restart = 0;
    reg [7:0]count_fall;
    reg [7:0]count_pipe;
    reg [7:0]random_count = 0;
    reg [2:0]random = 0;
    reg [3:0]random_count2 = 0;
    reg [3:0]temp = 0;
    parameter 	    BLANK = 8'hff,
				ZERO = 8'hc0,
				ONE = 8'hf9,
				TWO = 8'ha4,
				THREE = 8'hb0,
				FOUR = 8'h99,
				FIVE = 8'h92,
				SIX = 8'h82,
				SEVEN = 8'hf8,
				EIGHT = 8'h80,
				NINE = 8'h90;
initial begin
    gameover = 0;
    temp = 0;
end
always@(posedge clk)
    begin
        random_count = random_count + 1;
        random = (random_count+random_count2)%8;
        if(jump==1 || start==1 || restart==1)  begin        //first time activate
            start = 1;
            
            if(!gameover)begin    
                count_fall = count_fall +1;
                count_pipe = count_pipe +1;
                
                row <= row_p;
                col <= col_t;
                case (c)
                    1: begin
                        if (count_pipe >= 40) begin
                            col_t = col_t >> 1;
                            random_count2 = random_count2 +acc;
                            //count_pipe = 0;
                        	if(col_t==col_b)begin
								for ( k=0 ;k< 7 ;k=k+1 ) begin
									collison[k] = row_b[k] & row_p[k];
								end
							if(collison==8'b00000000)begin										
								score = score + 1;
							end
							else    
								gameover <= 1;
							end  
							count_pipe = 0;  
						end
                        else if (col_t == 8'b00000000) begin
                            col_t=8'b10000000;
                            case (random)
                                0:begin
                                    row_p = row_p0;
                                end 
                                1:begin
                                    row_p = row_p1;
                                end
                                2:begin
                                    row_p = row_p2;
                                end
                                3:begin
                                   row_p = row_p3; 
                                end
                                4:begin
                                   row_p = row_p4;
                                end
                                5:begin
                                   row_p = row_p5; 
                                end
                                6:begin
                                   row_p = row_p6; 
                                end
                                7:begin
                                   row_p = row_p7;
                                end
                                
                            endcase
                        end
                        c = 0;
                        end
                    0: begin
                        row = row_b;
                        col = col_b;
                        if (count_fall >= 50) begin
                            row_b = row_b << 1;//+acc 
                            count_fall = 0;
                            acc = acc + 1;
                        end
                        if(jump) begin
                            if (!jump_f) begin
                                row_b = row_b >> 1;
                                acc = 0;
                                jump_f = 1;
                            end
                        end
                        else jump_f=0;
                        
                        
                        if (row_b == 8'b00000000 ) begin
                            gameover <= 1;
                            restart <= 1;
                        end
                        c = c + 1;
                    end
                endcase
                case (score/10)
                    0:begin
                        tens = ZERO;
                    end 
                    1:begin
                        tens = ONE;
                    end 
                    2:begin
                        tens = TWO;
                    end 
                    3:begin
                        tens = THREE;
                    end 
                    4:begin
                        tens = FOUR;
                    end 
                    5:begin
                        tens = FIVE;
                    end 

                    6:begin
                        tens = SIX;
                    end
                    7:begin
                        tens = SEVEN;
                    end 
                    8:begin
                        tens = EIGHT;
                    end 
                    9:begin
                        tens = NINE;
                    end 
                    
                    default: tens = ZERO;
                endcase
                case (score%10)
                    0:begin
                        units = ZERO;
                    end 
                    1:begin
                        units = ONE;
                    end 
                    2:begin
                        units = TWO;
                    end 
                    3:begin
                        units = THREE;
                    end 
                    4:begin
                        units = FOUR;
                    end 
                    5:begin
                        units = FIVE;
                    end 

                    6:begin
                        units = SIX;
                    end
                    7:begin
                        units = SEVEN;
                    end 
                    8:begin
                        units = EIGHT;
                    end 
                    9:begin
                        units = NINE;
                    end 
                    
                    default: units = ZERO;
                endcase
                
			end
			else begin          //clear all reg for the next game
				start = 1;
				restart = 1;
				collison = 0;
				count_pipe=0;
				count_fall=0;
				acc = 0;
				jump_f=0;
				c = 0;
				row_p = 8'b11000111;
				col_t = 8'b10000000;
				row_b = 8'b00001000;
				col_b = 8'b00000010;
                case(temp)	
						0:begin	
							col = 8'b00000001; //sad face
							row = 8'b10001100;
							temp = temp+1;end
						1:begin	
							col = 8'b00000010;
							row = 8'b01000010;
							temp = temp+1;end
						2:begin
							col = 8'b00000100;
							row = 8'b00101100;
							temp = temp+1;end
						3:begin
							col = 8'b00001000;
							row = 8'b01000000;
							temp = temp+1;end
						4:begin
							col = 8'b00010000;
							row = 8'b01000000;
							temp = temp+1;end
						5:begin
							col = 8'b00100000;
							row = 8'b00101100;
							temp = temp+1;end
						6:begin
							col = 8'b01000000;
							row = 8'b01000010;
							temp = temp+1;end
						7:begin
							col = 8'b10000000;
							row = 8'b10001100;
							temp = 0;end
					endcase
                if(jump == 1) begin
                    gameover = 0;
                    score = 0;
                    
                end
                else begin
					case(temp)	
						0:begin	
							col = 8'b00000001; //sad face
							row = 8'b10001100;
							temp = temp+1;end
						1:begin	
							col = 8'b00000010;
							row = 8'b01000010;
							temp = temp+1;end
						2:begin
							col = 8'b00000100;
							row = 8'b00101100;
							temp = temp+1;end
						3:begin
							col = 8'b00001000;
							row = 8'b01000000;
							temp = temp+1;end
						4:begin
							col = 8'b00010000;
							row = 8'b01000000;
							temp = temp+1;end
						5:begin
							col = 8'b00100000;
							row = 8'b00101100;
							temp = temp+1;end
						6:begin
							col = 8'b01000000;
							row = 8'b01000010;
							temp = temp+1;end
						7:begin
							col = 8'b10000000;
							row = 8'b10001100;
							temp = 0;end
					endcase
						  //draw a sad face 
				end
			end
		end
    end
always@(posedge clk and gameover)
begin
    case(temp)	
						0:begin	
							col = 8'b00000001; //sad face
							row = 8'b10001100;
							temp = temp+1;end
						1:begin	
							col = 8'b00000010;
							row = 8'b01000010;
							temp = temp+1;end
						2:begin
							col = 8'b00000100;
							row = 8'b00101100;
							temp = temp+1;end
						3:begin
							col = 8'b00001000;
							row = 8'b01000000;
							temp = temp+1;end
						4:begin
							col = 8'b00010000;
							row = 8'b01000000;
							temp = temp+1;end
						5:begin
							col = 8'b00100000;
							row = 8'b00101100;
							temp = temp+1;end
						6:begin
							col = 8'b01000000;
							row = 8'b01000010;
							temp = temp+1;end
						7:begin
							col = 8'b10000000;
							row = 8'b10001100;
							temp = 0;end
					endcase
end
endmodule 