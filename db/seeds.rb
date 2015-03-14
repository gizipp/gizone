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
Blog.create(domain: 'ndorokakung.com',
            title_selector: '#entry-content > div.post > h2',
            content_selector: '#entry-content > div.post > div.entry > p')
Blog.create(domain: 'missviona.blogspot.com',
            title_selector: '#Blog1 > div.blog-posts > div > div > div > div.post > h3',
            content_selector: '#Blog1 > div.blog-posts > div > div > div > div.post > div.post-body')
Blog.create(domain: 'radityadika.com',
            title_selector: '#pagewrap > div.content > article > h1',
            content_selector: '#pagewrap > div.content > article > div.entry-content')
Blog.create(domain: 'www.kalipengging.com',
            title_selector: '#main > article > div.entry-wrapper > header > h1',
            content_selector: '#main > article > div.entry-wrapper > div.entry-content > p')
Blog.create(domain: 'www.andreasharsono.net')
Blog.create(domain: 'www.benablog.com',
            title_selector: '#Blog1 > div.blog-posts.hfeed > div > div > div > div.post > h3',
            content_selector: '#postingan')
Blog.create(domain: 'zulhaq.com',
            title_selector: '#content > article > header > h1',
            content_selector: '#content > article > div.entry-content')
Blog.create(domain: 'www.salsabeela.com',
            title_selector: '#page > div.main-container > div > div.column-one > article > header > h2',
            content_selector: '#page > div.main-container > div > div.column-one > article > div.entry-content')
Blog.create(domain: 'www.shitlicious.com',
            title_selector: '#Blog1 > div.blog-posts.hfeed > div > div > div > article > div > div > header > h1 > a',
            content_selector: '#Blog1 > div.blog-posts.hfeed > div > div > div > article > div > div > div.post-content')