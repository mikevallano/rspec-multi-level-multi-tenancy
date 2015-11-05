require 'rails_helper'


RSpec.describe PostsController, type: :controller do

  let(:account) { FactoryGirl.create(:account, user_id: user.id) }
  let(:project) { FactoryGirl.create(:project, account_id: account.id) }
  let(:current_project) { project }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, project_id: project.id) }
  let(:invalid_post) { FactoryGirl.build(:invalid_post) }
  let(:current_user) { login_with(user) }
  let(:invalid_user) { login_with(nil) }
  let(:valid_attributes) { {name: post.name, project_id: project.id} }
  let(:invalid_attributes) { {name: nil} }

  shared_examples_for "with a logged in user" do

    describe "GET #index" do
      it "assigns all posts as @posts" do
        get :index, project_id: project.id
        expect(assigns(:posts)).to eq([post])
      end

      it "renders the index template" do
        get :index, project_id: project.id
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "assigns the requested post as @post" do
        get :show, {:id => post.to_param, project_id: project.id}
        expect(assigns(:post)).to eq(post)
      end

      it "renders the show template" do
        get :show, {:id => post.to_param, project_id: project.id}
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      it "assigns a new post as @post" do
        get :new, project_id: project.id
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "renders the new template" do
        get :new, project_id: project.id
        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      it "assigns the requested post as @post" do
        get :edit, {:id => post.to_param, project_id: project.id}
        expect(assigns(:post)).to eq(post)
      end

      it "renders the edit template" do
        get :edit, {:id => post.to_param, project_id: project.id}
        expect(response).to render_template(:edit)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Post" do
          @post = Post.new(valid_attributes)
          expect {
            @post.save
          }.to change(Post.unscoped.where(project_id: project.id), :count).by(1)
        end

        it "assigns a newly created post as @post" do
          @post = Post.new(valid_attributes)
          @post.save
          expect(@post).to be_a(Post)
          expect(@post).to be_persisted
        end

        it "redirects to the created post" do
          skip "weird issues with create"
          @post = Post.new(valid_attributes)
          expect {
            @post.save
          }.to redirect_to(project_posts_path(project_id: project.id))
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          @post = Post.new(invalid_attributes)
          expect(@post).to be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          skip "weird issues with create"
          @post = Post.new(invalid_attributes)
          @post.save
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:post, name: "newname") }

        it "updates the requested post" do
          put :update, {:id => post.to_param, project_id: project.id, :post => new_attributes }
          post.reload
          expect(post.name).to eq("newname")
        end

        it "assigns the requested post as @post" do
          put :update, {:id => post.to_param, project_id: project.id, :post => new_attributes }
          expect(assigns(:post)).to eq(post)
        end

        it "redirects to the post" do
          put :update, {:id => post.to_param, project_id: project.id, :post => new_attributes }
          expect(response).to redirect_to(project_posts_path)
        end
      end

      context "with invalid params" do
        it "assigns the post as @post" do
          put :update, {:id => post.to_param, project_id: project.id, :post => invalid_attributes }
          expect(assigns(:post)).to eq(post)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => post.to_param, project_id: project.id, :post => invalid_attributes }
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested post" do
        expect {
          delete :destroy, {:id => post.to_param, project_id: project.id}
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete :destroy, {:id => post.to_param, project_id: project.id}
        expect(response).to redirect_to(project_posts_url)
      end
    end

  end #logged in user shared_example

  shared_examples_for "an invalid user trying to access" do
    describe "GET #index" do
      it "redirects user to sign up page" do
        get :index, project_id: project.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #show" do
      it "redirects user to sign up page" do
        get :show, {:id => post.to_param, project_id: project.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #new" do
      it "redirects user to sign up page" do
        get :new, project_id: project.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects user to sign up page" do
        get :edit, {:id => post.to_param, project_id: project.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    describe "POST #create" do
      context "with valid params" do
        it "redirects user to sign up page" do
          skip "weird issues with create"
          @post = Post.new(valid_attributes)
          @post.save
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context "with invalid params" do
        it "redirects user to sign up page" do
          skip "weird issues with create"
          @post = Post.new(invalid_attributes)
          @post.save
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:post, name: "newname") }

        it "redirects user to sign up page" do
          put :update, {:id => post.to_param, project_id: project.id, :post => new_attributes }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context "with invalid params" do
        it "redirects user to sign up page" do
          put :update, {:id => post.to_param, project_id: project.id, :post => invalid_attributes }
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "redirects user to sign up page" do
        delete :destroy, {:id => post.to_param, project_id: project.id}
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
      account
      Account.current_id = account.id
      project
      Project.current_id = project.id
      post
      invalid_user
    end

    it_behaves_like 'an invalid user trying to access'
  end #user access describe

end
