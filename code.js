// Prototype inheritance 

function Animal(sound) {
  this.sound = sound
}

Animal.prototype.speak = function() {
  return this.sound
}

function Dog(sound, name) {
  Animal.call(this, sound)
  this.name = name
}

Dog.prototype = Object.create(Animal.prototype)
Dog.prototype.constructor = Dog

function Cat(sound, name, color) {
  Animal.call(this, sound)
  this.name = name
  this.color = color
}

Cat.prototype = Object.create(Animal.prototype)
Cat.prototype.constructor = Cat

Cat.prototype.paintCat = function(color) {
  this.color = color
}

var animal = new Animal("rawr")
animal.speak() // "rawr"

var dog = new Dog("bark", "Snoopy")
dog.speak() // "bark"
dog.name // "Snoopy"

var cat = new cat("meow", "Garfield", "orange")
cat.speak() // "meow"
cat.name // "Garfield"
cat.color // "orange"
cat.paintCat("blue")
cat.color // "blue"


// this 

var hero = "Megaman"
var game = {
  hero: "Mario",
  properties: {
    hero: "Link",
    heroName: function() {
      return this.hero
    }
  }
}

game.properties.heroName() // "Link"
var getHeroName = game.properties.heroName
getHeroName() // "Megaman"