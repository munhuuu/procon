#!/usr/bin/ruby
require 'prime'
class Integer
	def sopfr()      self.prime_division.reduce(0){|s,(n,p)|s+(n*p)} end
	def factornum()  self.prime_division.reduce(0){|s,(n,p)|s+p} end
	def dfactornum() self.prime_division.reduce(0){|s,(n,p)|s+1} end
	def sopf()       self.prime_division.reduce(0){|s,(n,p)|s+n} end

	def divisornum() self.prime_division.reduce(1){|s,(n,p)|s*(p+1)} end
	def divisorsum() self.prime_division.reduce(1){|s,(n,p)|s*(n**(p+1)-1)/(n-1)} end
	def totient()    self.prime_division.reduce(1){|s,(n,p)|s*(n-1)*n**(p-1)} end

	def derivative() self.prime_division.reduce(0){|s,(n,p)|s+self*p/n} end
end
N=100000000
K=100000
a=1.step(N).map(&:divisornum)
puts :ok
p 1.step(N-K+1).reduce(0){|s,i|
	p if i%100==0
	s+a[i-1,K].max
}