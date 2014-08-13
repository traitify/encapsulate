class Collections < Grape::API
  resource :api do
    format :json
    
    post "/:resource" do
      {
        "#{params[:resource]}" =>{
          posted: "here"
        }
      }
    end
    
    get "/:resource" do
      {
        "#{params[:resource]}" =>{
          geted: "here"
        }
      }
    end
    
    delete "/:resource" do
      {
        "#{params[:resource]}" =>{
          deleted: "here"
        }
      }
    end
    
    put "/:resource" do
      {
        "#{params[:resource]}" =>{
          puted: "here"
        }
      }
    end
  end
end