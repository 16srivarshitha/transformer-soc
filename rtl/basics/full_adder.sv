module full_adder(
    input logic a,
    input logic b,
    input logic carry_in,
    output logic sum,
    output logic carry_out
);

logic sum_ab;
logic carry_ab;
logic carry_sum;

half_adder ha1(
    .a(a),
    .b(b),
    .sum(sum_ab),
    .carry(carry_ab)
);

half_adder ha2(
    .a(sum_ab),
    .b(carry_in),
    .sum(sum),
    .carry(carry_sum)
);

assign carry_out = carry_ab | carry_sum;

endmodule