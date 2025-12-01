#!/usr/bin/env perl

use warnings;
use strict;
use feature qw( say );

use Carp qw(croak);

sub part1 {
    my $input = shift;

    my $dial_is_at = 50;
    my $zeroes     = 0;

    foreach my $n ( @$input ) {
        my $dir    = substr( $n, 0, 1 );
        my $clicks = substr( $n, 1, length $n );

        my $next = $dir eq 'R' ? $dial_is_at + $clicks : $dial_is_at - $clicks;
        $dial_is_at = $next % 100;

        if ( $dial_is_at == 0 ) {
            $zeroes++;
        }
    }

    return $zeroes;
}

sub part2 {
    my $input = shift;

    my $dial_is_at = 50;
    my $zeroes     = 0;

    foreach my $n ( @$input ) {
        my $dir           = substr( $n, 0, 1 );
        my $clicks        = substr( $n, 1, length $n );
        my $more_than_100 = int( abs( $clicks / 100 ) );
        my $after_full    = $clicks % 100;

        my $next = $dir eq 'R' ? $dial_is_at + $after_full : $dial_is_at - $after_full;
        if ( $dial_is_at != 0 && ( $next >= 100 || $next <= 0 ) ) {
            $zeroes++;
        }

        $zeroes += $more_than_100;
        $dial_is_at = $next % 100;
    }

    return $zeroes;
}

sub main {
    open my $fh, '<', 'day01.input' or croak "Can't open file: $!";
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
