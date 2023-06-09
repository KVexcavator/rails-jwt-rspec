require 'rails_helper'

RSpec.describe "Books", type: :request do
  let!(:books) { create_list(:book, 5) }
  let(:book_id) { books.first.id }
  let(:user) { create(:user) }

  describe "GET /books" do
    before { get '/api/v1/books', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
    it "returns books" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /books/:id" do
    before { get "/api/v1/books/#{book_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
    context "when book exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "returns the book item" do
        expect(json['id']).to eq(book_id)
      end
    end
    context "when book does not exist" do
      let(:book_id) { 0 }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to include("Couldn't find Book with 'id'=0")
      end
    end
  end

  describe "POST /books/:id" do
    let!(:fancy) { create(:category) }
    let(:valid_attributes) do
      { title: 'The Hobbit', author: 'J.R.R. Tolkien',
        category_id: fancy.id }
    end

    context "when request attributes are valid" do
      before { post '/api/v1/books', params: valid_attributes, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
    context "when an invalid request" do
      before { post '/api/v1/books', params: {}, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
      it "returns starus code 422" do
        expect(response).to have_http_status(422)
      end
      it "returns a failure message" do
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe "PUT /books/:id" do
    let(:valid_attributes) { { title: 'KVexcavator' } }
    before { put "/api/v1/books/#{book_id}", params: valid_attributes, headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
    context "when book exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
      it "updates the book" do
        updated_item = Book.find(book_id)
        expect(updated_item.title).to match(/KVexcavator/)
      end
    end
    context "when the book does not exist" do
      let(:book_id) { 0 }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to include("Couldn't find Book with 'id'=0")
      end
    end
  end

  describe "DELETE /books/:id" do
    before { delete "/api/v1/books/#{book_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }
    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
