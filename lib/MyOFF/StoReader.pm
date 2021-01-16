package MyOFF::StoReader;

use utf8;
use Dancer2;
use Storable;
use Dotenv -load;

use MyOFF::Split;

our $VERSION = '0.1';
our $ROOT = $ENV{"PRODUCTS_ROOT"};

print "$ROOT\n";
my $barcode = "3990116170001";

get '/' => sub {
    template 'index' => { 'title' => 'MyOFF::StoReader' };
};

get '/products/:barcode' => sub {
    # my $result = retrieve "\%PRODUCTS_ROOT/$path/product.sto";
    # my $encoded_result = encode_json $result;
    my $barcode = route_parameters->get('barcode');
    # print "Barcode: [$barcode]\n";
    my $path = MyOFF::Split::split_code($barcode);
    # print "Barcode: [$path]\n";

    template 'product' => { 'title' => 'MyOFF::StoReader', 'barcode' => $barcode, 'path' => $path };
};

true;
