use strict;
use warnings;
use Test::More;
use Weather::Underground::Forecast;
use LWP::Simple;
use Data::Dumper::Concise;

my $wunder_forecast = Weather::Underground::Forecast->new(
    location          => '59802',
    temperature_units => 'fahrenheit',    # or 'celsius'
);

isa_ok( $wunder_forecast, 'Weather::Underground::Forecast' );
can_ok( 'Weather::Underground::Forecast', ( 'temperatures', 'precipitation' ) );

SKIP:
{

    # Test internet connection
    my $source_URL = $wunder_forecast->_query_URL;
    my $head    = head($source_URL);
    skip( 'Skipping live test using Internet', 3 ) if !$head;

    my ( $highs, $lows ) = $wunder_forecast->temperatures;
    my $chance_of_precip = $wunder_forecast->precipitation;
    is( ref($highs),            'ARRAY', 'highs data structure' );
    is( ref($lows),             'ARRAY', 'lows data structure' );
    is( ref($chance_of_precip), 'ARRAY', 'precips data structure' );
}

done_testing();
