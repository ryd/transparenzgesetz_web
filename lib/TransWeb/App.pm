package TransWeb::App;
use Dancer ':syntax';

our $VERSION = '0.1';

our @BUTTONS = qw(start entwurf verlauf elbphilharmonie impressum);
our %BUTTONS_DEF = (
    start => {
        title => "Start",
        link => "/site/start",
    },
    elbphilharmonie => {
        title => "Elbphilharmonie",
        link => "/site/elbphilharmonie",
    },
    ifg => {
        title => "IFG",
        link => "/site/ifg",
    },
    links => {
        title => "Verweise",
        link => "/site/links",
    },
    verlauf => {
        title => "Verlauf",
        link => "",
    },
    entwurf => {
        title => "Entwurf",
        link => "",
    },
    impressum => {
        title => "Impressum",
        link => "/site/impressum",
    },
    facebook => {
        title => "facebook",
        link => "/facebook",
    },
    twitter => {
        title => "twitter",
        link => "/twitter",
    },
);

# Settings
set 'layout'       => 'main';

# Routings
get '/' => sub {
    redirect '/site/start';
};

get '/site/:page' => sub {
    my $page = params->{page};
    # check if valid page
    return send_error("Seite nicht gefunden", 404) 
        if ($page =~ /^\d+$/);

    # render page
    template "$page" => { page => $page };
};
         
get '/twitter' => sub {
    redirect 'http://twitter.com/TransGesetzHH"';
};

get '/facebook' => sub {
    redirect 'http://facebook.com/page/TransparenzGesetzHH';
};

# Buttons
before_template sub {
   my $tokens = shift;

   my $content = '';
   foreach my $b ( @BUTTONS ) {
       $content .= $b eq $tokens->{page} ? 
            button_pressed_html($BUTTONS_DEF{$b}):
            button_html($BUTTONS_DEF{$b});
   }

   $tokens->{'button'} = $content;
};

sub button_html {
    my $b = shift;
    return '<a href="'.$b->{link}.'"><span class="button b_released">'.
        $b->{title}.'</span></a>';
}

sub button_pressed_html {
    my $b = shift;
    return '<span class="button b_pressed">'.
        $b->{title}.'</span>';
}

true;
