use warnings;
use strict;
use feature 'say';

use Data::Dumper;
use RPi::WiringPi;
use RPi::WiringPi::Constant qw(:all);
use Test::More;

# physical pin numbers

my $i_base = 35;
my $o_base = 40;

my $mod = 'RPi::WiringPi';


{ # wpi

    my $pi = $mod->new(setup => 'wpi');

    my $i_pin = $pi->phys_to_wpi($i_base);
    my $o_pin = $pi->phys_to_wpi($o_base);

    my $i = $pi->pin($i_pin);
    my $p = $pi->pin($o_pin);
  
    is $i->num, 24, "wpi input pin number ok";
    is $p->num, 29, "wpi output pin number ok";
    
    $i->mode(INPUT);
    $p->mode(OUTPUT);

    $p->write(HIGH);
    
    is $i->read, HIGH, "wpi setup ok";

    $p->write(LOW);

    $pi->cleanup;

    is $i->read, LOW, "wpi input pin is low";
    is $i->mode, INPUT, "wpi input pin back to input";
    is $p->mode, INPUT, "wpi output pin back to output";
}

{ # gpio


    my $pi = $mod->new(setup => 'gpio');

    my $i_pin = $pi->phys_to_gpio($i_base);
    my $o_pin = $pi->phys_to_gpio($o_base);

    my $i = $pi->pin($i_pin);
    my $p = $pi->pin($o_pin);

    is $i->num, 19, "gpio input pin number ok";
    is $p->num, 21, "gpio output pin number ok";

    $i->mode(INPUT);
    $p->mode(OUTPUT);

    $p->write(HIGH);
    
    is $i->read, HIGH, "gpio setup ok";

    $p->write(LOW);

    $pi->cleanup;

    is $i->read, LOW, "gpio input pin is low";
    is $i->mode, INPUT, "gpio input pin back to input";
    is $p->mode, INPUT, "gpio output pin back to output";
}

{ # phys

    my $pi = $mod->new(setup => 'phys');

    my $i = $pi->pin($i_base);
    my $p = $pi->pin($o_base);
  
    is $i->num, 35, "phys input pin number ok";
    is $p->num, 40, "phys output pin number ok";

    $i->mode(INPUT);
    $p->mode(OUTPUT);

    $p->write(HIGH);
    
    is $i->read, HIGH, "phys setup ok";

    $p->write(LOW);

    $pi->cleanup;

    is $i->read, LOW, "phys input pin is low";
    is $i->mode, INPUT, "phys input pin back to input";
    is $p->mode, INPUT, "phys output pin back to output";
}

done_testing();