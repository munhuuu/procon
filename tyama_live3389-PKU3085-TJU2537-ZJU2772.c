i;main(n,a,b,d){for(scanf("%d",&n);i<n;printf("%d %d QUARTER(S), %d DIME(S), %d NICKEL(S), %d PENNY(S)\n",++i,a,b,d/5,d%5))scanf("%d",&d),a=d/25,d%=25,b=d/10,d%=10;}