#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( './day02.pl' );

sub test_input {
    return
"11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";
}

subtest 'Day 02 Part 1' => sub {
    my @input = map { [ split /-/x, $_ ] } split /,/x, test_input();
    is( part1( \@input ), 1227775554, 'Correct result' );
};

subtest 'Day 02 Part 2' => sub {
    my @input = map { [ split /-/x, $_ ] } split /,/x, test_input();
    is( part2( \@input ), 4174379265, 'Correct result' );
};

done_testing();
