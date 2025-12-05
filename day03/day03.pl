#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use List::Util;
use Carp qw(croak);
use Data::Dump;

sub find_max {
    my $nums      = shift;
    my $start_idx = shift // 0;
    my $stop_idx  = shift // $#{$nums};

    foreach my $max ( -9 .. -1 ) {
        $max = -$max;
        my $max_pos = List::Util::first { $nums->[$_] == $max } $start_idx .. $stop_idx;
        next unless defined $max_pos;

        return $max_pos, $nums->[$max_pos];
    }

    return -1, 0;
}

sub part1 {
    my $input = shift;
    my $count = 0;

    foreach my $row ( @$input ) {
        my @nums = split //x, $row;
        my ( $idx,  $v1 ) = find_max( \@nums, 0,        $#nums - 1 );
        my ( undef, $v2 ) = find_max( \@nums, $idx + 1, $#nums );

        $count += int( "$v1$v2" );
    }

    return $count;
}

sub part2 {
    my $input = shift;
    my $count = 0;

    foreach my $row ( @$input ) {
        my @nums         = split //x, $row;
        my $previous_idx = 0;
        my $num          = "";

        foreach my $i ( -11 .. 0 ) {
            $i = -$i;
            my ( $idx, $v ) = find_max( \@nums, $previous_idx, $#nums - $i );

            $num          = "${num}${v}";
            $previous_idx = $idx + 1;
        }

        $count += int( $num );
    }

    return $count;
}

sub main {
    open my $fh, '<', 'day03.input' or croak "Can't open file: $!";
    my @lines = <$fh>;
    close $fh;
    chomp @lines;

    my $part1 = part1( \@lines );
    my $part2 = part2( \@lines );

    say "Part 1: $part1";
    say "Part 2: $part2";

    return 1;
}

if ( @ARGV ) {
    main();
}

1;
