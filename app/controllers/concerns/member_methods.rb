module MemberMethods
  def movie_params
    params.permit(:movie_id)
  end

  def member_params(member)
    params.require(member).permit([ :name, :birth_date, :birth_place])
  end

  def valid_member_params?(member, d_params)
    if d_params[:name].empty?
      flash[:alert] = "#{member.to_s.titleize} needs a name."
      return false
    end
    return true
  end

  def create_member(member)
    m_params = member_params(member)
    if valid_member_params?(member, m_params)
      movie_id = movie_params
      movie = Movie.find_by(id: movie_id[:movie_id])
      movie.send("#{member}s").create(m_params)
      redirect_to movie_path(movie)
    else
      redirect_to request.referrer
    end
  end

  def new_member(member)
    movie_id = movie_params
    if(!movie_id.empty?)
      m = Movie.find_by(id: movie_id[:movie_id])
      new_member = m.send("#{member}s").build
      return { member: new_member, movie: m }
    end
  end

  def destroy_member(member)
    found_member_class = "#{member.to_s.titleize}".constantize
    found_member = found_member_class.find_by(id: params.permit(:id)[:id])
    found_member.delete
    redirect_to request.referrer
  end
end
