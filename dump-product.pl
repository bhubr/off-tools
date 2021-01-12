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

$barcode = $1;
$path = split_code($barcode);

# my $file = '/mnt/podata/products/004/815/162/3426/product.sto';
my $result = retrieve "/mnt/podata/products/$barcode/product.sto";

# use Data::Dumper;
# $Data::Dumper::Purity = 1;
# print Dumper($result);

$encoded_result = encode_json $result;
print $encoded_result;