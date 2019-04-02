# frozen_string_literal: true

json.array! @readings, partial: 'readings/reading', as: :reading
