#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( './day01.pl' );

sub test_input {
    return qw{
      L68
      L30
      R48
      L5
      R60
      L55
      L1
      L99
      R14
      L82
    };
}

subtest 'Day 01 Part 1' => sub {
    my @input = test_input();
    is( part1( \@input ), 3, 'Result should be 3' );
};

subtest 'Day 01 Part 2' => sub {
    my @input = test_input();
    is( part2( \@input ), 6, 'Resut should be 6' );
};

done_testing();
