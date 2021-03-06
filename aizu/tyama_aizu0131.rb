#!/usr/bin/ruby
def lightsout(x,y)
  #now=Time.now.to_f
  succ=0
  a=Array.new(x*y)
  a.size.times{|i| a[i]=Array.new(2)}

  #create problem
  x.times{|i|
    y.times{|j|
      a[i+j*x][0]=1<<(i+j*x)
      a[i+j*x][1]= 0 +
        (1<<(i+j*x)) +
        (i>0   ? 1<<(i-1+j*x) : 0) +
        (i<x-1 ? 1<<(i+1+j*x) : 0) +
        (j>0   ? 1<<(i+(j-1)*x) : 0) +
        (j<y-1 ? 1<<(i+(j+1)*x) : 0) +
        0
    }
  }

  #solve
  (x*y).times{|i|
    if a[i][1]&1<<i==0
      (i+1).step(x*y-1) {|j|
        if a[j][1]&1<<i!=0
          a[i],a[j]=a[j],a[i]
          succ=1
          break
        end
      }
      if succ==0 then break end
      succ=0
    end

    (x*y).times{|j|
      if i!=j && a[j][1]&1<<i!=0
        a[j][0]^=a[i][0]
        a[j][1]^=a[i][1]
      end
    }

    #$stderr.printf("%d/%d passes\r",i+1,x*y)
  }
  #$stderr.puts

	gets.to_i.times{
		prob=[];ans=[0]*x*y
		y.times{prob+=gets.split.map(&:to_i)}
		(x*y).times{|i|if prob[i]>0 then (x*y).times{|j|ans[j]^=a[j][0][i]}end}
		y.times{|i|puts ans[i*x,x].map(&:to_s)*' '}
	}

=begin
  #output as C
  print <<"EOM"
#include <stdio.h>
int table[#{x*y}][#{x*y}]={
EOM

  a.each{|b|
    print "  {"
    a.size.times{|c|
      print "#{b[0][c]},"
    }
    print "},\n"
  }

  print <<"EOM"
};
int prob[#{x*y}], ans[#{x*y}];

main(b,c,i,j){
  for(scanf("%d",&c);b<=c;b++){
    for(i=0;i<#{x*y};i++)
      scanf("%d",prob+i),ans[i]=0;
    for(i=0;i<#{x*y};i++)
      if(prob[i])
        for(j=0;j<#{x*y};j++)
          ans[j]^=table[i][j];
    for(j=0;j<#{y};printf("\\n"),j++)
      for(i=0;i<#{x};i++)
        printf(i<#{x-1}?"%d ":"%d",ans[i+j*#{x}]);
  }
  return 0;
}
EOM
$stderr.printf("%.3f ms\n",Time.now.to_f-now)
=end
end

lightsout(10,10)