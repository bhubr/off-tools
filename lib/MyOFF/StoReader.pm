package MyOFF::StoReader;

use utf8;
use Dancer2;
use Storable;
use JSON qw//;;
use Dotenv -load;

use MyOFF::Split;

our $VERSION = '0.1';
our $ROOT = $ENV{"PRODUCTS_ROOT"};

print "$ROOT\n";
my $barcode = "3990116170001";

set engines =>
{
    serializer =>
    {
        JSON =>
        {
           allow_nonref => 1
        },
    }
};

set serializer      => 'JSON';
set content_type    => 'application/json';

# get '/' => sub {
#     template 'index' => { 'title' => 'MyOFF::StoReader' };
# };

get '/products/:barcode' => sub {
    my $barcode = route_parameters->get('barcode');
    my $path = MyOFF::Split::split_code($barcode);
    my $result = retrieve "$ROOT/$path/changes.sto";
    # my $encoded_result = encode_json $result;
    return $result;
    # template 'product' => {
    #     'title' => 'MyOFF::StoReader',
    #     'barcode' => $barcode,
    #     'path' => $path,
    #     'product' => $encoded_result
    # };
};

true;
