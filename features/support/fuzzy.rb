
class FuzzyMatch

  def self.match got, want
    if got == want
      return true
    elsif want.match /(.*)\s+~(.+)%$/       #percentage range: 100 ~5%
      margin = 1 - $2.to_f*0.01
      from = $1.to_f*margin
      to = $1.to_f/margin
      return got.to_f >= from && got.to_f <= to
    elsif want.match /(.*)\s+\+\-(.+)$/    #absolute range: 100 +-5
      margin = $2.to_f
      from = $1.to_f-margin
      to = $1.to_f+margin
      return got.to_f >= from && got.to_f <= to
    elsif want =~ /^\/(.*)\/$/             #regex: /a,b,.*/
      return got =~ /#{$1}/
    else
      return false
    end      
  end
  
  def self.match_location got, want
    match( got[0], "#{want.lat} ~0.0025%" ) &&
    match( got[1], "#{want.lon} ~0.0025%" )
  end
  
end

