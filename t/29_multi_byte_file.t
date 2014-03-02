#!/usr/bin/perl

# Testing of PPI::Document::File

use strict;
BEGIN {
	no warnings 'once';
	$| = 1;
	$PPI::XS_DISABLE = 1;
	$PPI::Lexer::X_TOKENIZER ||= $ENV{X_TOKENIZER};
}

use Test::More tests => 6;
use Test::NoWarnings;
use File::Spec::Functions ':ALL';
use PPI::Document::File;

#####################################################################
# Creating Documents

SCOPE: {
	# From a specific file
	my $file = catfile('t', 'data', 'multi_byte.pl');
	ok( -f $file, 'Found test file' );

	# Load from the file
	my $doc = PPI::Document::File->new( $file, utf8 => 1 );
	isa_ok( $doc, 'PPI::Document::File' );
	isa_ok( $doc, 'PPI::Document'       );
	is( $doc->filename, $file, '->filename ok' );

	ok !PPI::Document::File->new( $file ), 'cannot get doc without utf8 option';
}
