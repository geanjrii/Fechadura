module Fechadura(ledverde, ledvermelho, clock, reset_n, senhaDigitada);
	
	input clock, reset_n;
	
	input [5:0] senhaDigitada;
	
	output logic ledverde, ledvermelho;
	
	logic [3:0] estadoAtual;
	
	parameter chk1 = 1, chk2 = 2, chk3 = 3, chk4 = 4, chk5 = 5, chk6 = 6, aberto = 7, senhaErrada = 8, fechado = 9;
	
	parameter senha = 6'b101100;
	
	var cont = 0;
	
	always_comb begin
		case(estadoAtual)
			aberto: begin
				ledverde = 1; ledvermelho = 0;
			end
			senhaErrada: begin
				ledverde = 0;ledvermelho = 1;
			end
			fechado: begin
				ledverde = 0; ledvermelho = 0;
			end
			chk1: begin
				ledverde = 0; ledvermelho = 0;
			end 
			chk2: begin
				ledverde = 0; ledvermelho = 0;
			end
			chk3: begin
				ledverde = 0; ledvermelho = 0;
			end
			chk4: begin
				ledverde = 0; ledvermelho = 0;
			end
			chk5: begin
				ledverde = 0; ledvermelho = 0;
			end
			chk6: begin
				ledverde = 0; ledvermelho = 0;
			end
		endcase
	end
	
	always_ff @(posedge clock) begin
		case(estadoAtual)
			chk1: begin
				if(senhaDigitada[0] == senha[0]) begin
					estadoAtual <= chk2;
				end
				else begin
					cont = cont+1;
					estadoAtual = chk2;
				end
			end
			chk2: begin
				if(senhaDigitada[1] == senha[1]) begin
					estadoAtual <= chk3;
				end
				else begin
					cont = cont+1;
					estadoAtual = chk3;
				end
			end
			chk3: begin
				if(senhaDigitada[2] == senha[2]) begin
					estadoAtual <= chk4;
				end
				else begin
					cont = cont+1;
					estadoAtual = chk4;
				end
			end
			chk4: begin
				if(senhaDigitada[3] == senha[3]) begin
					estadoAtual <= chk5;
				end
				else begin
					cont = cont+1;
					estadoAtual = chk5;
				end
			end
			chk5: begin
				if(senhaDigitada[4] == senha[4]) begin
					estadoAtual <= chk6;
				end
				else begin
					cont = cont+1;
					estadoAtual = chk6;
				end
			end
			chk6: begin
				if(senhaDigitada[5] == senha[5]) begin
					estadoAtual <= aberto;
				end
				else begin
					estadoAtual = senhaErrada;
				end
			end
			senhaErrada: begin
				cont = 0;
				estadoAtual <= fechado;
			end
			fechado: begin
				estadoAtual <= chk1;
			end			
		endcase
	end
endmodule
