require 'digest/sha1'
class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :views
  before_validation :generate_sha

  validates :sha, uniqueness: true

  def generate_sha
    self.sha = Digest::SHA1.hexdigest("#{name} #{user.nickname}")
  end

  def refresh_issues(apirepo, current_user)
    update_count = 0
    apirepo.views.flatten.each { |view|
      if views.find_by(name: view.name)
        if !views.find_by(sha: view.sha)
          views.find_by(name: view.name).update(sha: view.sha)
          view.post_issue(current_user, self.name, view.first.path)
          update_count += 1
        end
      else
        views.new(name: view.name, path: view.path, sha: view.sha)
        view.post_issue(current_user, self.name, view.first.path)
        update_count += 1
      end
    }
    [self, update_count]
  end
end
