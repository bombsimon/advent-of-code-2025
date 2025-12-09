package Util;

=head1 NAME

Util - My AoC utils

=head1 SYNOPSIS

    use Util;

    my $input = Util::read_file( "input.txt" );
    my $lines = Util::lines( $input );
    my $grid  = Util::grid( $input );

=head1 DESCRIPTION

Tools shared across implementations

=cut

use warnings;
use strict;
use feature qw(say);

use Carp qw(croak);

=head2 read_file

Open a file and return it as a string without trailing newline

=cut

sub read_file {
    my $input = shift;
    my $lines;
    {

        local $/;              ## no critic (Variables::RequireInitializationForLocalVars)
        open my $fh, '<', $input or croak "Can't open file: $!";
        $lines = <$fh>;
        close $fh;
    };

    return $lines;
}

=head2 lines

Convert a string into an array split on newlines.

=cut

sub lines {
    my $input = shift;
    my @lines = split /\n/x, $input;
    chomp @lines;

    return \@lines;
}

=head2 grid

Convert a string into an array split on newlines and each row is split on whitespace.

    my $str = <<"EOF";
    one   two   three
    four  five  six
    seven eight nine
    EOF;

    my $grid = Util::grid( $str );
    # [
    #   ["one", "two", "three"],
    #   ["four", "five", "six"],
    #   ["seven", "eight", "nine"]
    # ]

=cut

sub grid {
    my $input     = shift;
    my $delimiter = shift // "\\s+";
    my $lines     = lines( $input );
    my @grid      = map { [ split /$delimiter/x ] } @$lines;

    return \@grid;
}

1;
