#!/usr/bin/env perl

use warnings;
use strict;

use lib "../";
use Util;

use Test::More;

require_ok( './day06.pl' );

sub test_input {
    return <<"INPUT";
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   + 
INPUT
}

subtest 'Day 01 Part 1' => sub {
    my $input = Util::grid( test_input() );
    is( part1( $input ), 4277556, 'Correct result' );
};

subtest 'Day 01 Part 2' => sub {
    my $input = Util::lines( test_input() );
    is( part2( $input ), 3263827, 'Correct result' );
};

done_testing();
