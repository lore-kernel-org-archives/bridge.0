Mime-Version: 1.0
Message-Id: <p05111b00bba2061773df@[10.96.96.13]>
In-Reply-To: <20030927202200.GA612@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
Date: Thu, 2 Oct 2003 19:22:53 +0200
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-net@vger.kernel.org, bridge@osdl.org, marcelo.tosatti@cyclades.com, shemminger@osdl.org

At 22:22 Uhr +0200 27.09.2003, Santiago Garcia Mantinan wrote:
>Hi!
>
>Since the change to 2.4.22 I've been experimenting problems here, after
>many tests I have seen what I think is the problem that is causing this.
>

I use 2.4.23-pre3 + 2 bridging related patches:
shemminger	1.1109.2.4 
	[BRIDGE]: Clear hw checksum flags when bridging.
karlis	1.1063.40.5	[BRIDGE]: kfree --> kfree_skb.
[both of them are in 2.4.23-pre4]

I was able to reproduce this only once: I did a ^Z on the bash of the 
listening 'nc':
uml:~# ps -o pid,stat,cmd,wchan=WIDE-WCHAN-COLUMN 2179 2188
   PID STAT CMD              WIDE-WCHAN-COLUMN
  2179 T    nc -n -l -p 8888 signal
  2188 S    nc localhost 888 wait_for_tcp_memory

It didn't continue when I sent a SIGCONT but stayed in 'T'-state. 
Then I did a 'fg':
uml:~# ps -o pid,stat,cmd,wchan=WIDE-WCHAN-COLUMN 2179 2188
   PID STAT CMD              WIDE-WCHAN-COLUMN
  2179 S    nc -n -l -p 8888 read_chan
  2188 S    nc localhost 888 wait_for_tcp_memory

I thought that 'read_chan' is stange an hit Return. Then everything 
resumed back to normal (i.e. tcpdump shows lots of packets).

I have 3 bridges active and one of them has blocked port, but I don't 
think this is related to the bridging code.


Perhaps you could try again with 2.4.23-pre[456].


Hannes
