require 'sinatra'
require 'json_resume'
require 'shellwords'
require 'securerandom'
require 'rest_client'

class HelloWorldApp < Sinatra::Base
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, ".") }

    post '/convert' do
        json_input = Shellwords.escape(params['input'])
        temp_hash = SecureRandom.hex
        temp_cache = "/cache/" + temp_hash
        dest_dir = Dir.pwd + temp_cache

        #html_pdf
        type = 'html_pdf'
        system("json_resume convert --out=#{type} --dest_dir='#{dest_dir}' #{json_input}")

        # html
        type = 'html'
        system("json_resume convert --out=#{type} --dest_dir='#{dest_dir}' #{json_input}")

        #md
        type = 'md'
        system("json_resume convert --out=#{type} --dest_dir='#{dest_dir}' #{json_input}")
        contents = File.open(dest_dir + '/resume.md').read
        dict = {"public"=>false, "files" => {"#{temp_hash}.md" => { "content" => contents}}}
        resp = RestClient.post "https://api.github.com/gists", dict.to_json
        resp = JSON.parse(resp)
        md_cont = "<script src='#{resp['html_url']}.js'></script>"
        File.open(dest_dir + "/md_page.html", 'w') {|f| f.write(md_cont) }

        return temp_cache
    end
end
