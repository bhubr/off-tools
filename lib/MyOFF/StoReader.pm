package MyOFF::StoReader;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'MyOFF::StoReader' };
};

true;
