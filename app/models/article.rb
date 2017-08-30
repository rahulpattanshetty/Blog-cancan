class Article < ActiveRecord::Base
belongs_to :user
has_many :article_categories
has_many :categories, through: :article_categories


validate :check_published_date
validate :check_user_articles
validate :check_category_limit

private

def check_published_date
	if self.published_date < Date.today
		self.errors.add(:published_date, "Cannot be less than today dates")
	end
end
def check_user_articles
	binding.pry
	#count = Article.where('user_id=?',self.user_id).length
	if (self.user.articles.length >= 3) && (self.user.role? "author") 
		self.errors.add(:user_id, "Limit exceeds")
	end
end
def check_category_limit
	if self.categories.length >= 3
		self.errors.add(:category,"Limit exceeds")
	end
end
end