#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( './day04.pl' );

sub test_input {
    return qw{
      ..@@.@@@@.
      @@@.@.@.@@
      @@@@@.@.@@
      @.@@@@..@.
      @@.@@@@.@@
      .@@@@@@@.@
      .@.@.@.@@@
      @.@@@.@@@@
      .@@@@@@@@.
      @.@.@@@.@.
    };

}

subtest 'Day 01 Part 1' => sub {
    my @input = test_input();
    is( part1( \@input ), 13, 'Correct result' );
};

subtest 'Day 01 Part 2' => sub {
    my @input = test_input();
    is( part2( \@input ), 43, 'Correct result' );
};

done_testing();
