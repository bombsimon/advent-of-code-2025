#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use lib "../";
use Util;

use Clone;
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

    my %cache = ();

    my ( $sx, $sy ) = ( 0, 0 );

  FIND: foreach my $x ( 0 .. $#{$input} ) {
        foreach my $y ( 0 .. $#{ $input->[$x] } ) {
            my $val = $input->[$x]->[$y];
            if ( $val eq "S" ) {
                ( $sx, $sy ) = ( $x, $y );
                last FIND;
            }
        }
    }

    $count = traverse_from( $input, $sx + 1, $sy, \%cache );

    return $count;
}

sub traverse_from {
    no warnings "recursion";   ## no critic (TestingAndDebugging::ProhibitNoWarnings): We know we're only at ~140

    my $input = shift;
    my $x     = shift;
    my $y     = shift;
    my $cache = shift;

    my $paths = 0;

    if ( $cache->{"$x,$y"} ) {
        return $cache->{"$x,$y"};
    }

    my $next = $input->[ $x + 1 ]->[$y] // "";
    return 1 unless $next;

    if ( $next eq "." ) {
        return traverse_from( $input, $x + 1, $y, $cache );
    }
    elsif ( $next eq "^" ) {
        $paths += traverse_from( $input, $x + 1, $y - 1, $cache );
        $paths += traverse_from( $input, $x + 1, $y + 1, $cache );
    }
    else {
        say "nothing ('$next') at x=$x,y=$y";
    }

    $cache->{"$x,$y"} = $paths;

    return $paths;
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

    # Do part2 first because we mutate the grid in part 1
    my $part2 = part2( $lines );
    my $part1 = part1( $lines );

    say "Part 1: $part1";
    say "Part 2: $part2";

    return 1;
}

if ( @ARGV ) {
    main();
}

1;
