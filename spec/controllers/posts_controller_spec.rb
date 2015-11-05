require 'rails_helper'


RSpec.describe PostsController, type: :controller do

  let(:account) { FactoryGirl.create(:account) }
  let(:project) { FactoryGirl.create(:project) }
  let(:current_project) { project }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, project_id: project.id) }
  let(:invalid_post) { FactoryGirl.build(:invalid_post) }
  let(:current_user) { login_with(user) }
  let(:invalid_user) { login_with(nil) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:post) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_post) }

  shared_examples_for "with a logged in user" do

    describe "GET #index" do
      it "assigns all posts as @posts" do
        account
        Account.current_id = account.id
        binding.pry
        get :index, project_id: project.id
        binding.pry
        expect(assigns(:posts)).to eq([post])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "assigns the requested post as @post" do
        get :show, {:id => post.to_param}
        expect(assigns(:post)).to eq(post)
      end

      it "renders the show template" do
        get :show, {:id => post.to_param}
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      it "assigns a new post as @post" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      it "assigns the requested post as @post" do
        get :edit, {:id => post.to_param}
        expect(assigns(:post)).to eq(post)
      end

      it "renders the edit template" do
        get :edit, {:id => post.to_param}
        expect(response).to render_template(:edit)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Post" do
          expect {
            post :create, {:post => valid_attributes}
          }.to change(Post.unscoped.where(project_id: project.id), :count).by(1)
        end

        it "assigns a newly created post as @post" do
          post :create, {:post => valid_attributes}
          expect(assigns(:post)).to be_a(Post)
          expect(assigns(:post)).to be_persisted
        end

        it "redirects to the created post" do
          post :create, {:post => valid_attributes}
          expect(response).to redirect_to(Post.unscoped.where(project_id: project.id).last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          post :create, {:post => invalid_attributes}
          expect(assigns(:post)).to be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          post :create, {:post => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:post, name: "newname") }

        it "updates the requested post" do
          put :update, {:id => post.to_param, :post => new_attributes }
          post.reload
          expect(post.name).to eq("newname")
        end

        it "assigns the requested post as @post" do
          put :update, {:id => post.to_param, :post => new_attributes }
          expect(assigns(:post)).to eq(post)
        end

        it "redirects to the post" do
          put :update, {:id => post.to_param, :post => new_attributes }
          expect(response).to redirect_to(post)
        end
      end

      context "with invalid params" do
        it "assigns the post as @post" do
          put :update, {:id => post.to_param, :post => invalid_attributes }
          expect(assigns(:post)).to eq(post)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => post.to_param, :post => invalid_attributes }
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested post" do
        expect {
          delete :destroy, {:id => post.to_param}
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete :destroy, {:id => post.to_param}
        expect(response).to redirect_to(posts_url)
      end
    end

  end #logged in user shared_example

  shared_examples_for "an invalid user trying to access" do
    describe "GET #index" do
      it "redirects user to sign up page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
      # it { is_expected.to redirect_to new_user_session_path }
    end

    describe "GET #show" do
      it "redirects user to sign up page" do
        get :show, {:id => post.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #new" do
      it "redirects user to sign up page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects user to sign up page" do
        get :edit, {:id => post.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    describe "POST #create" do
      context "with valid params" do
        it "redirects user to sign up page" do
          post :create, {:post => valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context "with invalid params" do
        it "redirects user to sign up page" do
          post :create, {:post => invalid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:post, name: "newname") }

        it "redirects user to sign up page" do
          put :update, {:id => post.to_param, :post => new_attributes }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context "with invalid params" do
        it "redirects user to sign up page" do
          put :update, {:id => post.to_param, :post => invalid_attributes }
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "redirects user to sign up page" do
        delete :destroy, {:id => post.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end #invalid user shared examples

  describe "user access within project" do
    before :each do
      account
      Account.current_id = account.id
      project
      Project.current_id = project.id
      current_user
      post
    end

    it_behaves_like 'with a logged in user'
  end #user access describe

  describe "invalid user access" do
    before :each do
      invalid_user
      post
    end

    it_behaves_like 'an invalid user trying to access'
  end #user access describe

end
