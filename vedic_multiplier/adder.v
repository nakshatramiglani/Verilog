module halfAdder(a, b, sum, carry);

    input  a, b;
    output sum, carry;

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule

module adder4(a, b, sum);

    input  [3:0] a, b;
    output [3:0] sum;
    wire   [3:0] sum;

    assign sum = a + b;

endmodule

module adder6(a, b, sum);

    input  [5:0] a, b;
    output [5:0] sum;
    wire   [5:0] sum;

    assign sum = a + b;

endmodule

module adder8(a, b, sum);

    input  [7:0] a, b;
    output [7:0] sum;
    wire   [7:0] sum;

    assign sum = a + b;

endmodule

module adder10(a, b, sum);

    input  [9:0] a, b;
    output [9:0] sum;
    wire   [9:0] sum;

    assign sum = a + b;

endmodule