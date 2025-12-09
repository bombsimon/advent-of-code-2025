#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use lib "../";
use Util;

use Data::Dump;

sub part1 {
    my $input = shift;
    my $count = 0;

    foreach my $x ( 0 .. $#{$input} ) {
        foreach my $y ( 0 .. $#{ $input->[$x] } ) {
            my $val  = $input->[$x]->[$y];
            my $next = $input->[ $x + 1 ]->[$y] // "";

            if ( $val eq "S" ) {
                $input->[ $x + 1 ]->[$y] = "|";
            }

            if ( $val eq "|" ) {
                if ( $next eq "." ) {
                    $input->[ $x + 1 ]->[$y] = "|";
                }
                elsif ( $next eq "^" ) {
                    $count++;
                    $input->[ $x + 1 ]->[ $y - 1 ] = "|";
                    $input->[ $x + 1 ]->[ $y + 1 ] = "|";
                }
            }
        }
    }

    return $count;
}

sub part2 {
    my $input = shift;
    my $count = 0;

    return $count;
}

sub print_grid {
    my $grid = shift;

    foreach my $row ( @$grid ) {
        foreach my $col ( @$row ) {
            print "$col";
        }

        say "";
    }

    return;
}

sub main {
    my $input = Util::read_file( "day07.input" );
    my $lines = Util::grid( $input, "" );

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
