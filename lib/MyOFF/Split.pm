package MyOFF::Split;

# From OFF Server
# https://github.com/openfoodfacts/openfoodfacts-server
# lib/ProductOpener/Product.pm
# FIXME: bug #677
sub split_code($) {
  print "SPLIT >>\n\n";
  my $code = $_[0];
  print "SPLIT $code\n\n";

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

# # (1) quit unless we have the correct number of command-line args
# $num_args = $#ARGV + 1;
# if ($num_args != 1) {
#     print "\nUsage: dump.pl <barcode>\n";
#     exit;
# }

1;