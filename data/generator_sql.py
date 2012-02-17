import os,random,time,string

def id_generator(size=10, chars=string.ascii_uppercase + string.digits):
	return ''.join(random.choice(chars) for x in range(size))
def strTimeProp(start, end, format, prop):
    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))

def randomDate(start, end, prop):
    return strTimeProp(start, end, '%Y-%m-%d-%H.%M.%s', prop)
def date_generator():
    return randomDate("1/1/2000 1:30 PM", "1/1/2011 4:50 AM", random.random())
def new_date():
    return randomDate("1/2/2011 1:30 PM", "1/1/2012 4:50 AM", random.random())
def rand_bool():
    if random.randrange(1,3) ==1:
	    return False
    else:
	    return True
def str_generator():
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    string = ''
    for x in random.sample(alphabet,random.randint(5,15)):
      string+=x
    return string


user_count=10000
fav_recipe_count = 30000
recipes_count = 500
comments_count=100000
ratings_count=50000
picture_count=1000
picture_rating_count=50000
ingredients_count = 500
constituents_count=2500
subcategory_count=25

users=[]
favorites=[]
recipes=[]
comments=[]
subcategories=[]
ratings=[]
pictures=[]
pic_ratings=[]
ingredients=[]
constituents=[]
units=[]

unique_key = 100001
#units
ulist = [ "cup", "dash", "drop","feet","fluid ounce","gallon", "gram", "inch", "liter","meter","ounce", "pinch","pint","pound","quart","tablespoon"," teaspoon", "unit" ]
utype = [ False,False,False,False,False,False,False,False,False,False,False,False,False, True,True,True,False,True ]
for i in range(len(ulist)):
    unique_key +=1
    tup=(unique_key, ulist[i], utype[i] )
    units.append(tup)


unit_list=[]
unit_list.append('default')
unit_list.append('imperial')
unit_list.append('metric')
for i in xrange(user_count):
	#create user tuple
	#unique_key,username,first_name, last_name, date_joined, password, email, photo, unit_preference, recipes_displayed, show_email, is_moderator, favorite_chef
	unique_key +=1
	random.shuffle(unit_list)

	tup = ( unique_key,
	id_generator(),
	str_generator(),
	str_generator(),
	date_generator(),
	id_generator(),
	str_generator() + "@" + str_generator()+".com",
	'NULL',
	unit_list[0],
	rand_bool(),
	random.randrange(1,100),
	rand_bool(),
	rand_bool(),
	'NULL' )
	users.append(tup)

for i in xrange(subcategory_count):
    unique_key +=1
    #id, name, category,
    tup = (unique_key, str_generator(), random.randrange(1,5) )
    subcategories.append(tup)



for i in xrange(ingredients_count):
    unique_key +=1
    tup = (unique_key, str_generator() )
    ingredients.append(tup)


for i in xrange(recipes_count):
    unique_key+=1
    vegan = rand_bool()
    vegetarian=rand_bool()
    if ( vegan):
        vegetarian = True

    tup = (unique_key,
    str_generator(), # title
    random.choice(users)[0], #fk to user. author
    str_generator() + str_generator() + str_generator(), #instructions
    random.randrange(10,200), #cook time
    random.randrange(10,200), #preparation time
    date_generator(), #date added
    vegan,
    vegetarian,
    rand_bool(), #gluten
    rand_bool(), #lactose
    rand_bool(), #nut free
    random.randrange(1,10), #servings
    random.choice(subcategories)[0] )#fk to subcategories
    recipes.append(tup)

for i in xrange(constituents_count):
    unique_key+=1
    tup = ( unique_key,
    random.choice(ingredients)[0], #ingredients
    random.choice(recipes)[0], #recipes
    random.randrange(1, 200), #quantity
    random.choice(units)[0] ) #units
    constituents.append(tup)

for i in xrange(picture_count):
    unique_key +=1
    tup = (unique_key,
    random.choice(users)[0], #user
    random.choice(recipes)[0], #recipe
    date_generator(), #date added
    'NULL', #data
    str_generator() )
    pictures.append(tup)

for i in xrange(picture_rating_count):
    unique_key+=1
    tup = (unique_key,
    random.choice(users)[0], #user
    random.choice(pictures)[0], #picture
    random.randrange(1,10) ) #score
    pic_ratings.append(tup)

for i in xrange(ratings_count):
    unique_key+=1
    tup = ( unique_key,
    random.choice(users)[0], #user
    random.choice(recipes)[0], #recipe
    random.randrange(1,10) ) #score
    ratings.append(tup)

for i in xrange(fav_recipe_count):
    unique_key+=1
    tup = (unique_key,
    random.choice(users)[0], #user
    random.choice(recipes)[0], #recipe
    new_date() ) #date
    favorites.append(tup)

for i in xrange(comments_count):
    unique_key +=1
    tup = (unique_key,
    random.choice(users)[0], #user
    random.choice(recipes)[0], #recipe
    str_generator() + str_generator() + str_generator(), #message
    new_date() )
    comments.append(tup)

out=open("users.data","w")
for i in xrange(len(users)):
    print>>out, users[i]
out.close()

out=open("favorites.data","w")
for i in xrange(len(favorites)):
    print>>out, favorites[i]
out.close()

out=open("recipes.data","w")
for i in xrange(len(recipes)):
    print>>out, recipes[i]
out.close()

out=open("comments.data","w")
for i in xrange(len(comments)):
    print>>out, comments[i]
out.close()

out=open("subcategories.data","w")
for i in xrange(len(subcategories)):
    print >>out,subcategories[i]
out.close()
out=open("ratings.data","w")
for i in xrange(len(ratings)):
    print >>out,ratings[i]
out.close()
out=open("pictures.data","w")
for i in xrange(len(pictures)):
    print >>out,pictures[i]
out.close()
out=open("picratings.data","w")
for i in xrange(len(pic_ratings)):
    print >>out,pic_ratings[i]
out.close()
out=open("ingredients.data","w")
for i in xrange(len(ingredients)):
    print >>out,ingredients[i]
out.close()
out=open("constituents.data","w")
for i in xrange(len(constituents)):
    print >>out,constituents[i]
out.close()
out=open("units.data","w")
for i in xrange(len(units)):
    print >>out,units[i]
out.close()
