# frozen_string_literal: true

# This job is responsible for creating a consolidated installment from a
# list of installments and processing it.

module SolidusSubscriptions
  class ProcessInstallmentsJob < ApplicationJob
    queue_as SolidusSubscriptions.configuration.processing_queue

    # Process a collection of installments
    #
    # @param installment_ids [Array<Integer>] The ids of the
    #   installments to be processed together and fulfilled by the same order
    #
    # @return [Spree::Order] The order which fulfills the list of installments
    def perform(installment_ids)
      return if installment_ids.empty?

      installments = SolidusSubscriptions::Installment.where(id: installment_ids).
                     includes(subscription: [:line_items, :user])
      Checkout.new(installments).process
    end
  end
end
