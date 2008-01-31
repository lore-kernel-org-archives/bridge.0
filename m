Date: Thu, 31 Jan 2008 00:44:58 -0800 (PST)
From: Alex Shnitman <alexta69@yahoo.com>
Subject: Re: [Bridge] Bridge not functional after disconnect / connect
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <558132.22783.qm@web60424.mail.yahoo.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Hi,

lspci gives this:

02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

The first one is the one having the trouble. Is this hardware known to be problematic?

Thanks,
--Alex


----- Original Message ----
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: Alex Shnitman <alexta69@yahoo.com>
Cc: bridge@lists.linux-foundation.org
Sent: Thursday, January 31, 2008 12:22:22 AM
Subject: Re: [Bridge] Bridge not functional after disconnect / connect


On 
Wed, 
30 
Jan 
2008 
14:15:11 
-0800 
(PST)
Alex 
Shnitman 
<alexta69@yahoo.com> 
wrote:

> 
Hi,
> 
> 
I 
have 
two 
NICs 
on 
my 
machine, 
one 
connected 
to 
a 
router 
and 
is 
always 
up, 
and 
the 
other 
connected 
back-to-back 
to 
a 
laptop, 
and 
this 
one 
I 
disconnect 
and 
connect 
all 
the 
time. 
I 
created 
a 
bridge 
on 
top 
of 
these 
two 
interfaces, 
and 
it 
functions 
fine, 
except 
when 
I 
disconnect 
and 
connect 
the 
laptop, 
I 
have 
to 
remove 
it 
from 
the 
bridge 
and 
add 
it 
back 
before 
it 
starts 
bridging! 
In 
other 
words, 
I 
need 
to 
do 
"brctl 
delif 
br0 
eth0; 
brctl 
addif 
br0 
eth0".
> 
> 
The 
output 
of 
"brctl 
showmacs 
br0" 
and 
"brctl 
showstp 
br0" 
looks 
the 
same 
and 
perfectly 
correct 
before 
the 
removal/adding 
and 
after 
it. 
From 
playing 
around 
with 
Wireshark 
it 
seems 
to 
me 
that 
before 
delif/addif 
only 
broadcasts 
are 
received 
from 
the 
laptop; 
unicast 
packets 
do 
not 
appear 
there. 
I 
got 
all 
zeros 
in 
/proc/sys/net/bridge/*. 
It 
looks 
like 
everything 
is 
configured 
correctly.
> 
> 
Any 
idea 
at 
all 
why 
I 
see 
this 
behavior? 
Any 
tips 
as 
to 
how 
I 
might 
debug 
it?
> 
> 
The 
kernel 
I'm 
running 
is 
2.6.18 
from 
Debian 
Etch.

What 
hardware? 
There 
were 
many 
fixes 
since 
that 
old 
kernel.

-- 
Stephen 
Hemminger 
<stephen.hemminger@vyatta.com>





      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
