#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( './day05.pl' );

sub test_input {
    return qq{
3-5
10-14
16-20
12-18

1
5
8
11
17
32
};

}

subtest 'Day 01 Part 1' => sub {
    my $input = test_input();

    is( part1( $input ), 3, 'Correct result' );
};

subtest 'Day 01 Part 2' => sub {
    my $input = test_input();
    chomp $input;

    is( part2( $input ), 14, 'Correct result' );
};

done_testing();
