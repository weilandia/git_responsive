class APIView < OpenStruct

  def self.service(current_user)
    GithubService.new(current_user)
  end

  def self.all(current_user, repo)
    service(current_user).view_dir(repo).map do |view_sub_dir|
      if view_sub_dir.first[0] != :name
        nil
      elsif view_sub_dir[:path][-4..-1] == ".erb"
        APIView.new(view_sub_dir)
      else
        service(current_user).views(view_sub_dir[:name], repo).map do |view|
          APIView.new(view)
        end
      end
    end
  end
end
