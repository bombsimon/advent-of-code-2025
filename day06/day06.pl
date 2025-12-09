#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use lib "../";
use Util;

use Data::Dump;

my $ops = {
    "+" => sub {
        my ( $a, $b ) = @_;
        return $a + $b;
    },
    "*" => sub {
        my ( $a, $b ) = @_;
        return $a * $b;
    },
};

sub part1 {
    my $input = shift;
    my $count = 0;

    # Filter empty leading spaces. Dumb, but then we can use the generic `grid`
    # util.
    for my $row ( 0 .. $#$input - 1 ) {
        @{ $input->[$row] } = grep { $_ ne "" } @{ $input->[$row] };
    }

    my $rows = scalar @$input;
    my $cols = scalar @{ $input->[0] };

    foreach my $col ( 0 .. $cols - 1 ) {
        my $op  = $input->[-1]->[$col];
        my $sum = $input->[0]->[$col];

        # Skip last for op + second to last.
        foreach my $row ( 0 .. $rows - 3 ) {
            my $val = $input->[ $row + 1 ]->[$col];
            $sum = $ops->{$op}( $sum, $val );
        }

        $count += $sum;
    }

    return $count;
}

sub part2 {
    my $input = shift;
    my $count = 0;

    my $last_row_no_leading_op = substr( $input->[-1], 1, length $input->[-1] );
    my @last_row_whitespaces   = split /[^\s]/x, $last_row_no_leading_op;
    my @column_sizes           = map { length } @last_row_whitespaces;
    my @char_lines             = map { [ split //x ] } @$input;
    my @ops                    = split /\s+/x, $input->[-1];

    my $rows  = scalar @$input;
    my $cols  = scalar @column_sizes + 1;
    my $start = 0;

    # This is super fragile. The input contains trailing whitespaces after the
    # last operator so when we split on it, we get a trailing element with empty
    # spaces. If we trim trailing whitespaces, the last row would be $cols - 1
    # instead.
    # This is shit, but as long as the input has one or more trailing
    # whitespaces on the last row this will work.
    foreach my $column ( 0 .. $cols - 2 ) {
        my $is_last_row = $cols - 2;
        my $op          = $ops[$column];
        my $size        = $column == $is_last_row ? 4 : $column_sizes[$column];
        my $end         = $start + $size - 1;
        my $sum         = 0;

        foreach my $c ( -$end .. -$start ) {
            $c = -$c;
            my $val = "";

            foreach my $row ( 0 .. $rows - 2 ) {
                my $ch = $char_lines[$row]->[$c] // "";
                next if $ch =~ /^\s*$/x;

                $val = "${val}${ch}";
            }

            next unless $val;
            $val = int( $val );
            $sum = $sum ? $ops->{$op}( $sum, $val ) : $val;
        }

        $start = $end + 2;
        $count += $sum;
    }

    return $count;
}

sub main {
    my $input = Util::read_file( "day06.input" );
    my $grid  = Util::grid( $input, "\\s+" );
    my $lines = Util::lines( $input );

    my $part1 = part1( $grid );
    my $part2 = part2( $lines );

    say "Part 1: $part1";
    say "Part 2: $part2";

    return 1;
}

if ( @ARGV ) {
    main();
}

1;
