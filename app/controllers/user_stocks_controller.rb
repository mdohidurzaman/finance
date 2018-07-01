class UserStocksController < ApplicationController
    def create
       stock = Stock.find_by_sticker(params[:stock_sticker])
       if stock.blank?
        stock = Stock.new_from_lookup(params[:stock_sticker])
        stock.save
       end
       @user_stock = UserStock.create(user: current_user, stock: stock)
       flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to portfolio"
       redirect_to my_portfolio_path
    end
    
    def destroy
       stock = Stock.find(params[:id])
       @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
       @user_stock.destroy
       flash[:notice] = "Stock was successfully remove from portfolio"
       redirect_to my_portfolio_path
    end
end
