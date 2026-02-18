require "faker"

module SampleData
  HOST_COUNT = 10
  GUEST_COUNT = 20
  BOOKING_COUNT = 50
  LOCATIONS = [
    {
      name: "Ferry Building Marketplace",
      description: "Historic waterfront market hall and transit hub on the Embarcadero.",
      address: "1 Ferry Building",
      city: "San Francisco",
      state: "CA",
      postal_code: "94111",
      image: "https://upload.wikimedia.org/wikipedia/commons/4/45/San_Francisco_%28CA%2C_USA%29%2C_Ferry_Building_--_2012_--_4246.jpg"
    },
    {
      name: "Denver Union Station",
      description: "Restored Beaux-Arts landmark serving as Denver's central rail hub.",
      address: "1701 Wynkoop St",
      city: "Denver",
      state: "CO",
      postal_code: "80202",
      image: "https://upload.wikimedia.org/wikipedia/commons/1/16/Union_Station%2C_Denver%2C_Colorado.jpg"
    },
    {
      name: "Chicago Cultural Center",
      description: "Landmarked cultural venue with galleries, domes, and civic event spaces.",
      address: "78 E. Washington St.",
      city: "Chicago",
      state: "IL",
      postal_code: "60602",
      image: "https://upload.wikimedia.org/wikipedia/commons/d/d1/Chicago_Cultural_Center_%28Former_Chicago_Public_Library_Central_Building%29%2C_Michigan_Avenue%2C_Chicago%2C_IL.jpg"
    },
    {
      name: "Boston Public Library (McKim Building)",
      description: "Copley Square's historic main library with renowned architecture.",
      address: "700 Boylston St.",
      city: "Boston",
      state: "MA",
      postal_code: "02116",
      image: "https://upload.wikimedia.org/wikipedia/commons/7/77/2017_Boston_Public_Library_McKim_Building.jpg"
    },
    {
      name: "Seattle Central Library",
      description: "Downtown flagship library known for its glass-and-steel design.",
      address: "1000 4th Ave.",
      city: "Seattle",
      state: "WA",
      postal_code: "98104",
      image: "https://upload.wikimedia.org/wikipedia/commons/8/8d/Seattle_Central_Library_01.jpg"
    },
    {
      name: "New York Public Library (Schwarzman Building)",
      description: "Flagship NYPL building at Fifth Avenue and 42nd Street.",
      address: "476 Fifth Ave.",
      city: "New York",
      state: "NY",
      postal_code: "10018",
      image: "https://upload.wikimedia.org/wikipedia/commons/8/86/New_York_City%2C_Midtown_Manhattan%2C_New_York_Public_Library%2C_Stephen_A._Schwarzman_Building%2C_1897-1911._5th_Avenue_%282011%29.jpg"
    }
  ].freeze

  def self.load!(reset: true)
    if reset
      Booking.delete_all
      Location.delete_all
      User.delete_all
    end

    hosts = Array.new(HOST_COUNT) do |index|
      User.create!(
        email: "host#{index + 1}@example.com",
        password: "password",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        organization: Faker::Company.name,
        phone_number: Faker::PhoneNumber.phone_number,
        website: Faker::Internet.url
      )
    end

    guests = Array.new(GUEST_COUNT) do |index|
      User.create!(
        email: "guest#{index + 1}@example.com",
        password: "password",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        organization: Faker::Company.name,
        phone_number: Faker::PhoneNumber.phone_number,
        website: Faker::Internet.url
      )
    end

    locations = LOCATIONS.map do |location|
      Location.create!(
        name: location[:name],
        description: location[:description],
        address: location[:address],
        city: location[:city],
        state: location[:state],
        postal_code: location[:postal_code],
        image: location[:image],
        host: hosts.sample
      )
    end

    BOOKING_COUNT.times do
      location = locations.sample
      guest = guests.sample
      start_date = Faker::Date.forward(days: 60)
      end_date = start_date + rand(1..7)

      Booking.create!(
        location: location,
        guest: guest,
        started_at: start_date.to_s,
        ended_at: end_date.to_s
      )
    end
  end
end
