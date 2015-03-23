require 'spec_helper'

describe "Creating TODO lists" do
	it "redirects to the TODO index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")

	end

	it "displays an error when the TODO list has no name" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: ""
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the name isn't at least 3 characters long" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: "Hi"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the TODO list has no description" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: "Best list"
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end
	
	it "displays an error when the name isn't at least 3 characters long" do
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: "Best list"
		fill_in "Description", with: "Hi"
		click_button "Create Todo list"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end
	
end
