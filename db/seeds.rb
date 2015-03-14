# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Blog.create(domain: 'backpackstory.me',
            title_selector: '#wrapper > article > div.post-title.clear > h1',
            content_selector: '#wrapper > article > section')
Blog.create(domain: 'ndorokakung.com')
            title_selector: '#entry-content > div.post > h2',
            content_selector: '#entry-content > div.post > div.entry > p')
Blog.create(domain: 'missviona.blogspot.com',
            title_selector: '#Blog1 > div.blog-posts.hfeed > div > div > div > div.post.hentry > h3',
            content_selector: '#Blog1 > div.blog-posts.hfeed > div > div > div > div.post.hentry > div.post-body')
Blog.create(domain: 'radityadika.com')
            title_selector: '#pagewrap > div.content > article > h1',
            content_selector: '#pagewrap > div.content > article > div.entry-content')
Blog.create(domain: 'www.kalipengging.com')
            title_selector: '#main > article > div.entry-wrapper > header > h1',
            content_selector: '#main > article > div.entry-wrapper > div.entry-content')
Blog.create(domain: 'www.andreasharsono.net')
Blog.create(domain: 'zulhaq.com')
Blog.create(domain: 'www.salsabeela.com')
Blog.create(domain: 'www.shitlicious.com')