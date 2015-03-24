require 'spec_helper'

describe "Viewing todo_items" do
	let!(:todo_list) { TodoList.create( name: "Groceries", description: "List of groceries to buy." ) }

	before do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "List Items"
		end
	end

	it "displays the name of the todo_list" do
		within "h1" do
			expect(page).to have_content(todo_list.name)
		end
	end

	it "displays no items when the todo_list is empty." do
		expect(page).to have_content("TodoItems#index")
	end
end
