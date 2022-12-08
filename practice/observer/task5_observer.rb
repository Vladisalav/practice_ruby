require 'observer'
 
class Product
  include Observable
 
  def initialize
    @price = 100
  end
  def set_price
    @old_price = @price
    @price = 50 + rand(50)
    unless @price == @old_price
      changed
      notify_observers(@price)
    end
  end
end
 
class Customer
  def initialize(name, good_price, publisher)
    @customer   = name
    @good_price = good_price
    publisher.add_observer self
  end
  def update(price)
    unless price > @good_price
      puts @customer + " buy product for " + price.to_s + " dollars."
    end
  end
end
 
product = Product.new
 
ivan  = Customer.new("Ivan", 70)
vasya = Customer.new("Vasya", 80)
vova  = Customer.new("Vova", 90)
 
product.add_observer ivan
product.add_observer vasya
product.add_observer vova
 
10.times do
  product.set_price
  puts product.price
end


#add_observer — метод добавляет подписчика

#notify_observers — метод передает вызывает метод #update объекта — наблюдателя и может передавать в него некоторые значения.

#changed — устанавливает состояние объекта в «измененное». Без вызова этого метода подписчики не получат сообщения об изменениях.

#changed? — проверяет состояние объекта-уведомителя.

#count_observers — метод возвращает количество подписчиков.

#delete_observer — метод удаляет у объекта-уведомителя переданный в качестве аргумента подписчик.

#delete_observers — удаляет все подписчики.