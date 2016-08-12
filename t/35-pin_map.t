use strict;
use warnings;

use RPi::WiringPi;
use RPi::WiringPi::Constant qw(:all);
use Test::More;

my $mod = 'RPi::WiringPi';

if (! $ENV{PI_BOARD}){
    warn "\n*** PI_BOARD is not set! ***\n";
    $ENV{NO_BOARD} = 1;
}

my $pi = $mod->new(setup => 'none');

is $pi->gpio_scheme, 'NULL', "gpio_scheme() returns NULL if not set";
is $pi->gpio_scheme('BCM'), 'BCM', "gpio_scheme() returns BCM if setup() is sys";
is $pi->gpio_scheme('GPIO'), 'GPIO', "gpio_scheme() returns GPIO if setup() is gpio";
is $pi->gpio_scheme('PHYS_GPIO'), 'PHYS_GPIO', "gpio_scheme() returns BCM if setup() is phys";
is (
    $pi->gpio_scheme('wiringPi'),
    'wiringPi', 
    "gpio_scheme() returns 'wiringPi' if setup() is wiringPi"
);

{
    my $map = $pi->gpio_map('BCM');
    print "$map->{40}\n";

}
done_testing();
