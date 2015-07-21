require 'spec_helper'

describe "StaticPages" do


    # test for Home
    describe "Home page" do
        it "should have the content 'Sample App'" do
            visit '/static_pages/home'
            expect(page).to have_content('Sample App')
        end

        it "should have the right title" do
            visit '/static_pages/home'
            expect(page).to have_title('Ruby on Rails Tutorial Sample App | Home')
        end
    end


    # test for help
    describe "Help page" do
        it "should have the content 'Help'" do
            visit '/static_pages/help'
            expect(page).to have_content('Help')
        end

        it "should have the right title" do
            visit '/static_pages/help'
            expect(page).to have_title('Ruby on Rails Tutorial Sample App | Help')
        end
    end


    # test for about
    describe "About page" do
        it "should have content 'About Us'" do
            visit '/static_pages/about'
            expect(page).to have_content('About Us')
        end

        it "should have the right title" do
            visit '/static_pages/about'
            expect(page).to have_title('Ruby on Rails Tutorial Sample App | About Us')
        end
    end
end