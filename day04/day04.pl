#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use Carp qw(croak);
use Data::Dump;

sub do_remove {
    my @grid    = @_;
    my @removed = ();
    my $rows    = $#grid;
    my $cols    = $#{ $grid[0] };
    my $coords  = [ [ -1, 0 ], [ -1, -1 ], [ 0, -1 ], [ 1, -1 ], [ 1, 1 ], [ 1, 0 ], [ 0, 1 ], [ -1, 1 ], ];

    foreach my $x ( 0 .. $rows ) {
        foreach my $y ( 0 .. $cols ) {
            my $curr = $grid[$x][$y];
            next unless $curr eq "@";

            my $rolls = 0;
            foreach my $new_coords ( @$coords ) {
                my ( $a,  $b )  = @$new_coords;
                my ( $x1, $y1 ) = ( $x + $a, $y + $b );
                next if $x1 < 0 || $x1 > $rows || $y1 < 0 || $y1 > $cols;

                $rolls++ if $grid[$x1][$y1] eq "@";
            }

            push @removed, [ $x, $y ] if $rolls < 4;
        }
    }

    return \@removed;
}

sub part1 {
    my $input   = shift;
    my @grid    = map { [ split //x, $_ ] } @$input;
    my $removed = do_remove( @grid );

    return scalar @$removed;
}

sub part2 {
    my $input   = shift;
    my @grid    = map { [ split //x, $_ ] } @$input;
    my $count   = 0;
    my $removed = [ [ -1, -1 ] ];

    while ( @$removed ) {
        foreach my $cols ( @$removed ) {
            my ( $x, $y ) = @$cols;
            next if $x < 0 || $y < 0;
            $grid[$x][$y] = ".";
        }

        $removed = do_remove( @grid );
        $count += scalar @$removed;
    }

    return $count;
}

sub main {
    open my $fh, '<', 'day04.input' or croak "Can't open file: $!";
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
