#!/usr/bin/perl -w
use Storable;
use JSON::PP;

# From OFF Server
# lib/ProductOpener/Product.pm
# FIXME: bug #677
sub split_code($) {

	my $code = shift;
	# Require at least 4 digits (some stores use very short internal barcodes, they are likely to be conflicting)
	if ($code !~ /^\d{4,24}$/) {

		$log->info("invalid code", { code => $code }) if $log->is_info();
		return "invalid";
	}

	my $path = $code;
	if ($code =~ /^(...)(...)(...)(.*)$/) {
		$path = "$1/$2/$3/$4";
	}
	return $path;
}

# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: name.pl first_name last_name\n";
    exit;
}

$barcode = $ARGV[0];
$path = split_code($barcode);

my $result = retrieve "/mnt/podata/products/$path/product.sto";

# use Data::Dumper;
# $Data::Dumper::Purity = 1;
# print Dumper($result);

$encoded_result = encode_json $result;
print $encoded_result;