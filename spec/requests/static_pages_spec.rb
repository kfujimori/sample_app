require 'spec_helper'

describe "StaticPages" do


    subject { page }

    # test for Home
    describe "Home page" do
        before { visit root_path }

        it { should have_content    ('Sample App') }
        it { should have_title      (full_title('')) }
        it { should_not have_title  ('| Home') }
    end


    # test for help
    describe "Help page" do
        before { visit help_path }

        it { should have_content    ('Help') }
        it { should have_title      (full_title('Help')) }
    end

    # test for about
    describe "About page" do
        before { visit about_path }

        it { should have_content    ('About') }
        it { should have_title      (full_title('About')) }
    end


    # test for contact us
    describe "Contact page" do
        before { visit contact_path }

        it { should have_content    ('Contact') }
        it { should have_title      (full_title('Contact')) }
    end


end
