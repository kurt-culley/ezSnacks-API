class PaymentsController < ApplicationController

  def client_token
    @client_token = { 'client_token' => Braintree::ClientToken.generate }
    json_response(@client_token)
  end

  def status
    @payment = Order.find(params[:order_id]).payment
    if @payment
      @transaction = Braintree::Transaction.find(@payment.braintree_id)
      @status = { 'status' => @transaction.status}
      json_response(@status)
    else
      head :no_content
    end

  end

  def index
    @payment = Order.find(params[:order_id]).payment
    if @payment
      json_response(@payment)
    else
      head :no_content
    end
  end

  def create
    @order = Order.find(params[:order_id])
    if @order.payment.nil?
      @payment = @order.build_payment

      client_nonce = params[:payment_method_nonce]
      # Using fake-valid-nonce for testing

      result = Braintree::Transaction.sale(
          :amount => @order.sub_total,
          :payment_method_nonce => 'fake-valid-nonce',
          :options => {
              :submit_for_settlement => true
          }
      )

      if result.success? || result.transaction
        @payment.braintree_id = result.transaction.id
        @payment.save
        @order.status = :settling_payment
        @order.save
      end
      json_response(@payment, :created)
    else
      head :conflict
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    head :no_content
  end

  private

    def payment_params
      params.permit(:payment_method_nonce)
    end

end
