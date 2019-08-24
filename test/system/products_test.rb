require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "h1", text: "Product"
    assert_selector ".card-product", count: 2
  end

  test "lets a signed in user create a new product" do
    login_as users(:george)
    visit "/products/new"
    save_and_open_screenshot

    fill_in "product_name", with: "Le Wagon"
    fill_in "product_tagline", with: "Change your life: Learn to code"
    # save_and_open_screenshot

    click_on 'Create Product'
    # save_and_open_screenshot

    # Should be redirected to Home with new product
    assert_equal root_path, page.current_path
    assert_text "Change your life: Learn to code"
  end

  test "doen't create product if not given a name of product" do
    login_as users(:george)
    visit "/products/new"

    # fill_in "product_name", with: "Le Wagon"
    fill_in "product_tagline", with: "Change your life: Learn to code"
    # save_and_open_screenshot

    click_on 'Create Product'
    # save_and_open_screenshot

    # Should be redirected to Home with new product
    assert_equal '/products', page.current_path
    assert_text "Name can't be blank"
  end
end
