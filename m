Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Rx Buffer sizes on e1000
Date: Wed, 14 Nov 2007 10:20:37 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D4E@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
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

>I find regular PCI bus (32bit) tops out at about 600 Mbits/sec on most
>machines. For PCI-X (64 bit/133) a realistic value is 6 Gbits/sec. The
>problem is arbitration and transfer sizes. 

>That means for for normal PCI32, one gigabit card or 
>6 100Mbit Ethernet interfaces can saturate the bus. Also, all that
>I/O slows down the CPU and memory interface.

I'm seeing issues with only 110Mbits/sec of traffic. Ultimately I expect
to be using far more than that, but I really didn't expect to be
overloading the bus yet.

Leigh.

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org] 
Sent: Wednesday, 14 November 2007 9:47 AM
To: Leigh Sharpe
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Rx Buffer sizes on e1000


I find regular PCI bus (32bit) tops out at about 600 Mbits/sec on most
machines. For PCI-X (64 bit/133) a realistic value is 6 Gbits/sec. The
problem is arbitration and transfer sizes.

Absolute limit is:
PCI32 33MHz = 133MB/s
PCI32 66MHz = 266MB/s
PCI64 33MHz = 266MB/s
PCI64 66MHz = 533MB/s
PCI-X 133MHz = 1066MB/s 

That means for for normal PCI32, one gigabit card or 
6 100Mbit Ethernet interfaces can saturate the bus. Also, all that
I/O slows down the CPU and memory interface.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>

