package TransWeb::App;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    redirect '/site/start';;
};

get '/site/:page' => sub {
        # check if valid page
        return send_error("Seite nicht gefunden", 404) 
            if (params->{page} =~ /^\d+$/);

        # render page
        template params->{page};
};
         
true;
