require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list) { TodoList.create(name: "Groceries", description: "Grocery List") }

	def update_todo_list(options={})
		visit "/todo_lists"
		options[:name] ||= "My updated todo list"
		options[:description] ||= "My updated todo list description"
		
		todo_list = options[:todo_list]

		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Name", with: options[:name]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end
	
	it "updates a todo list successfully with correct input" do
		update_todo_list todo_list: todo_list, 
						 name: "New Name", 
						 description: "New Description"
		todo_list.reload
		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.name).to eq("New Name")
		expect(todo_list.description).to eq("New Description")
	end

	it "displays an error when the todo_list has no name" do
		update_todo_list todo_list: todo_list,
						 name: ""
		expect(page).to have_content("error")
	end

	it "displays an error when the todo_list's name is too short" do
		update_todo_list todo_list: todo_list,
						 name: "Hi"
		expect(page).to have_content("error")
	end

	it "displays an error when the todo_list has no description" do
		update_todo_list todo_list: todo_list,
						 description: ""
		expect(page).to have_content("error")
	end

	it "displays an error when the todo_list's description is too short" do
		update_todo_list todo_list: todo_list,
						 description: "Food"
		expect(page).to have_content("error")
	end

end
