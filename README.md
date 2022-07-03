# Shipment Tracker
Final project for our group at Le Wagon. The shipment tracker will be used by the NGO Aid Pioneers to send trucks of donations to Ukraine. 

## Target
A German NGO that is sending humanitarian aid to Ukraine.

## Pain
Shipments can get lost and delayed when truck contents and location are unclear. Also donors can't easily see where their donation ends up.

## Solution
A product that gets truck locations and shipment-info like routes, content and IDs from scanning QR-codes and shows these on a map.

## Dependencies
- `ruby 3.0.3`, best installed via [rbenv](https://github.com/rbenv/rbenv)
- `node 16.13.1`, best installed via [nvm](https://github.com/nvm-sh/nvm)
- [Yarn Version 1](https://classic.yarnpkg.com/en/), `npm install --global yarn`
- `rails 6.1.6` & `bundler 2.3.13`
- [PostgreSQL](https://www.postgresql.org/)

### Optional
- [Prettier](https://prettier.io/)
- `rubocop 1.30.0`

## Setup
1. Install Ruby dependencies via `bundle install`
2. Install Javascript dependencies via `yarn install`
3. Create `.env` file in the root project directory. It should contain:
    - `MAPBOX_API_KEY=<API-KEY-GOES-HERE>` with your own API key from [Mapbox](https://www.mapbox.com/)
4. Make sure PostgreSQL is running.
5. Run:
    1. `rails db:create`
    2. `rails db:migrate`
    3. `rails db:seed`
6. Run dev server using `rails s`
