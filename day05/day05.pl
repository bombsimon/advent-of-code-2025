#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use List::Util;
use Carp qw(croak);
use Data::Dump;

sub part1 {
    my $input = shift;
    my $count = 0;

    my ( $ranges, $ingredients ) = split /\n\n/x, $input;
    my @ranges      = map  { [ split /-/x ] } grep { $_ } split /\n/x, $ranges;
    my @ingredients = grep { $_ } split /\n/x, $ingredients;

  INGREDIENT: foreach my $ingredient ( @ingredients ) {
        foreach my $range ( @ranges ) {
            my ( $start, $stop ) = @$range;

            if ( $ingredient >= $start && $ingredient <= $stop ) {
                $count++;
                next INGREDIENT;
            }
        }
    }

    return $count;
}

sub part2 {
    my $input = shift;
    my $count = 0;

    my ( $ranges, undef ) = split /\n\n/x, $input;
    my @ranges = map  { [ split /-/x ] } grep { $_ } split /\n/x, $ranges;
    my @sorted = sort { @$a[0] <=> @$b[0] } @ranges;

    my $i = 0;
    while ( $i <= $#sorted ) {
        my $start   = $sorted[$i]->[0];
        my $max_end = $sorted[$i]->[1];
        my $j       = $i;

        while ( $j < $#sorted ) {
            my $next_starts_at = $sorted[ $j + 1 ]->[0];

            last if $next_starts_at > $max_end;

            $j++;
            $max_end = $sorted[$j]->[1] if $sorted[$j]->[1] > $max_end;
        }

        $count += ( $max_end - $start ) + 1;
        $i = $j + 1;
    }

    return $count;
}

sub main {
    my $lines;
    {

        local $/;              ## no critic (Variables::RequireInitializationForLocalVars)
        open my $fh, '<', 'day05.input' or croak "Can't open file: $!";
        $lines = <$fh>;
        close $fh;
    };

    my $part1 = part1( $lines );
    my $part2 = part2( $lines );

    say "Part 1: $part1";
    say "Part 2: $part2";

    return 1;
}

if ( @ARGV ) {
    main();
}

1;
