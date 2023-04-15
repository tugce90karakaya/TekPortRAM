module tek_port_ram

#(parameter adres_genisligi = 4,
  parameter veri_obegi = 16,
  parameter satir_sayisi = 16
  )

(input clk,
 input [adres_genisligi-1:0] adres,
 inout [veri_obegi-1:0] veri,
 input cip_aktif,
 input bellege_yaz,
 input bellekten_oku
);

reg [veri_obegi-1:0] temp_data;
reg [veri_obegi-1:0] bellek[satir_sayisi];

always @ (posedge clk) begin
    if(cip_aktif & bellege_yaz)
        bellek[adres] <= veri;
end

always @(posedge clk) begin
    if(cip_aktif & !bellege_yaz)
        temp_data <= bellek[adres];
end 

assign veri = cip_aktif & bellekten_oku & !bellege_yaz ? temp_data: 'hz;

endmodule