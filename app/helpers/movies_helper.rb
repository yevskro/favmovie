module MoviesHelper
  def add_hidden_id_tag_if_movie_update(movie)
    (hidden_field_tag :id, movie.id) if !movie.id.nil?
  end

  def delete_member_link_if_update(movie, member, member_index)
    link_to ":delete", send("destroy_#{member}_path", movie.send("#{member}s")[member_index].id), method: :delete if !movie.id.nil?
  end

  def add_member_link_if_update(movie, member)
    link_to ":add #{member.capitalize}", send("new_movie_#{member}_path", movie) if !movie.id.nil?
  end

  def create_members_if_not_updating(movie, members)
    2.times{ movie.send("#{members}").build } if movie.id.nil?
  end

  def members_nested_form(movie, members, form_builder)
    create_members_if_not_updating(movie, members)
    count = 0
    form_builder.fields_for members do |builder|
      count += 1
       b = yield(builder, count)
    end
  end

  def member_fields(form_builder, member)
    html = form_builder.text_field :name, placeholder: "#{member} name", class: "movie-text-field"
    html << "<br>".html_safe
    html << (form_builder.text_field :birth_date, placeholder: "#{member} birth date", class: "movie-text-field")
    html << "<br>".html_safe
    html << (form_builder.text_field :birth_place, placeholder: "#{member} birth place", class: "movie-text-field")
    html << "<br>".html_safe
  end

  def genre_belongs_to_movie?(movie, genre_name)
    movie.genres_names.include?(genre_name) ? true : false
  end

  def proper_submit_title_for_create_and_edit(movie)
    movie.name.nil? ? "Create" : "Edit"
  end

  def welcome_message
    current_user ? "Welcome, #{current_user.name}, here are FavMovies!!" : "Welcome, Guest, here are FavMovies!!"
  end

  def if_owner_show_movie_edit_delete_links(owner, movie)
    if(owner)
      html = link_to ":edit", edit_movie_path(movie)
      html << " "
      html << (link_to ":delete", destroy_movie_path(movie), method: :delete)
      return html.html_safe
    end
  end
end
