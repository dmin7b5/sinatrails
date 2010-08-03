before do
  # http://sinatra-book.gittr.com/#handling_of_rails_like_nested_params
  if request.post? or request.put?
    new_params = {}
    params.each_pair do |full_key, value|
      this_param = new_params
      split_keys = full_key.split(/\]\[|\]|\[/)
      split_keys.each_index do |index|
        break if split_keys.length == index + 1
        this_param[split_keys[index]] ||= {}
        this_param = this_param[split_keys[index]]
     end
     this_param[split_keys.last] = value
    end
    request.params.replace new_params
  end
end

get '/' do
  haml :index
end
