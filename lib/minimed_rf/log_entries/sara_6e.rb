module MinimedRF
  module PumpEvents

    # Got this from @bewest's decocare
    # https://github.com/bewest/decoding-carelink/blob/master/decocare/history.py#L673-L684

    class Sara6E < Base

      def self.event_type_code
        0x6e
      end

      def bytesize
        52
      end

      def valid_date
        year, month, day = parse_date_2byte(1)
        Date.new(year, month, day)
      end

      def valid_date_str
        d = valid_date
        sprintf("%04d-%02d-%02d", d.year, d.month, d.day)
      end

      def timestamp
        midnight = valid_date+1
        [midnight.year, midnight.month, midnight.day, 0, 0, 0]
      end

      def as_json
        super.merge({
          valid_date: valid_date_str
        })
      end

      def to_s
        "Sara6E #{timestamp_str}"
      end

    end
  end
end
