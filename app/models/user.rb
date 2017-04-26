class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   def admin?
      is_admin
   end
   has_many :resumes
   has_many :jobs
   has_many :collects
   has_many :participated_jobs, :through => :collects, :source => :job
   def is_member_of?(job)
     participated_jobs.include?(job)
   end
   def join!(job)
     participated_jobs << job
   end
   def quit!(job)
     participated_jobs.delete(job)
   end

end
