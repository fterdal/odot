require 'spec_helper'

describe "Viewing todo_items" do
	let!(:todo_list) { TodoList.create( name: "Groceries", description: "List of groceries to buy." ) }

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "displays the name of the todo_list" do
		visit_todo_list(todo_list)
		within "h1" do
			expect(page).to have_content(todo_list.name)
		end
	end

	it "displays no items when the todo_list is empty." do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo_list has items" do
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")
		
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(2)
		within "ul.todo_items" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Eggs")
		end


	end

end
