require 'test_helper'

class CrawlersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crawler = crawlers(:one)
  end

  test "should get index" do
    get crawlers_url
    assert_response :success
  end

  test "should get new" do
    get new_crawler_url
    assert_response :success
  end

  test "should create crawler" do
    assert_difference('Crawler.count') do
      post crawlers_url, params: { crawler: { is_active: @crawler.is_active, last_ran_at: @crawler.last_ran_at, link: @crawler.link, name: @crawler.name, status: @crawler.status } }
    end

    assert_redirected_to crawler_url(Crawler.last)
  end

  test "should show crawler" do
    get crawler_url(@crawler)
    assert_response :success
  end

  test "should get edit" do
    get edit_crawler_url(@crawler)
    assert_response :success
  end

  test "should update crawler" do
    patch crawler_url(@crawler), params: { crawler: { is_active: @crawler.is_active, last_ran_at: @crawler.last_ran_at, link: @crawler.link, name: @crawler.name, status: @crawler.status } }
    assert_redirected_to crawler_url(@crawler)
  end

  test "should destroy crawler" do
    assert_difference('Crawler.count', -1) do
      delete crawler_url(@crawler)
    end

    assert_redirected_to crawlers_url
  end
end
