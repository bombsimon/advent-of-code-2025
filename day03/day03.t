#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( './day03.pl' );

sub test_input {
    return qw{
      987654321111111
      811111111111119
      234234234234278
      818181911112111
    };

}

subtest 'Day 01 Part 1' => sub {
    my @input = test_input();
    is( part1( \@input ), 357, 'Correct result' );
};

subtest 'Day 01 Part 2' => sub {
    my @input = test_input();
    is( part2( \@input ), 3121910778619, 'Correct result' );
};

done_testing();
