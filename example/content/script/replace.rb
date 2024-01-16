main = $document.at_css("#main")

html = main.inner_html
html = html.gsub("Nanoc Site", "Opal Site")

main.inner_html = html

