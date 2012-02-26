# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
PredefinedTag.create([
    {context:'platforms', name:'Windows'},
    {context:'platforms', name:'Mac OS X'},
    {context:'platforms', name:'Linux x86'},
    {context:'platforms', name:'Linux x86_64'},
    {context:'platforms', name:'Android'}
]);
