module mod_12;
    bit clk;
    bit reset, load, mode;
    bit [7:0] data, count;

    // Reset should clear count
    property resetn; 
        @(posedge clk) reset |-> (count == 0);
    endproperty

    // Load should set count = data
    property loadn;
        @(posedge clk) load |-> (count == data);
    endproperty

    // Mode up should increment count
    property mode_up;
        @(posedge clk) (!load && mode) |-> (count == $past(count) + 1);
    endproperty

    // Mode down should decrement count
    property mode_down;
        @(posedge clk) (!load && !mode) |-> (count == $past(count) - 1);
    endproperty

    assert property(resetn);
    assert property(loadn);
    assert property(mode_up);
    assert property(mode_down);
endmodule
