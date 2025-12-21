module adder(Cout, sum, a, b, Cin);
    input a,b,Cin;
    output Cout, sum;
    assign sum = a^b^Cin;
    assign Cout = (a&b)|(b&Cin)|(Cin&a);
endmodule;