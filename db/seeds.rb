# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

30.times do |_n|
  Auth.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

6.times do |_n|
  Kanban.create!(
    name: "Project #{_n}",
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

# Kanban
Card.destroy_all
KanbanColumn.destroy_all
Kanban.destroy_all
my_kanban = Kanban.create(
  name: "New Lamborgucci project",
  description: "Project to build the most esthetically car ever made.",
)
backlog = KanbanColumn.create(
  name: "Backlog",
  kanban: my_kanban
)
Card.create(title: "Engine Building", content: "Build engine", position: 0,
            kanban_column: backlog)
Card.create(title: "Purchaser",
            content: "Purchase the tires",
            position: 1, kanban_column: backlog)
Card.create(title: "Cockpit Project", content: "Code the cockpit software",
            position: 2, kanban_column: backlog)
todo = KanbanColumn.create(
  name: "To Do",
  kanban: my_kanban
)
Card.create(title: "Card Design", content: "Design the car", position: 0,
            kanban_column: todo)
completed = KanbanColumn.create(
  name: "Completed",
  kanban: my_kanban
)
Card.create(title: "HR Requirement", content: "Build the engineer team",
            position: 0, kanban_column: completed)
Card.create(title: "Finnacial Task", content: "Find fundings", position: 1,
            kanban_column: completed)