class App < Grape::API
  resource :api do
    format :json
    
    get :birthday do
      { birthdays:[{ birthday: "world" }]}
    end
    
    get :name do
      { 
        name:{
          first: "Carson", 
          last: "Wright",
          fullName: "Carson Wright"
        }
      }
    end
    
    get :books do
      { 
        books:[
          {
            text: "awesomeness1"
          },
          {
            text: "awesomeness2"
          },
          {
            text: "awesomeness3"
          }
        ]
      }
    end
    
    helpers do
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

  end
end