#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use Carp qw(croak);

sub part1 {
    my $input = shift;
    my $count = 0;

    foreach my $range ( @$input ) {
        my ( $start, $end ) = @$range;

        for ( my $num = $start; $num <= $end; $num++ ) {
            my $length = length $num;
            next unless $length % 2 == 0;

            my $midpoint = $length / 2;
            my $l        = substr( $num, 0,         $midpoint );
            my $r        = substr( $num, $midpoint, $length - 1 );

            $count += $num if $l == $r;
        }
    }

    return $count;
}

sub part2 {
    my $input = shift;
    my $count = 0;

    foreach my $range ( @$input ) {
        my ( $start, $end ) = @$range;

        for ( my $num = $start; $num <= $end; $num++ ) {
            my $length = length $num;
            my @results;

            for my $num_groups ( 2 .. $length ) {
                next unless $length % $num_groups == 0;
                my $group_size = $length / $num_groups;

                my @segments;
                foreach my $i ( 0 .. $num_groups - 1 ) {
                    push @segments, int( substr( $num, $i * $group_size, $group_size ) );
                }

                push @results, \@segments;
            }

            foreach my $r ( @results ) {
                if ( keys %{ { map { $_ => 1 } @$r } } == 1 ) { ## no critic (BuiltinFunctions::ProhibitVoidMap)
                    $count += $num;
                    last;
                }
            }
        }
    }

    return $count;
}

sub main {
    open my $fh, '<', 'day02.input' or croak "Can't open file: $!";
    my @lines = <$fh>;
    chomp @lines;
    close $fh;

    @lines = map { [ split /-/x, $_ ] } split /,/x, $lines[0];

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
