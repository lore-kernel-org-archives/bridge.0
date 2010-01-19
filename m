Message-ID: <20100119214451.72637a94rn0biysz@mx.kpi.ua>
Date: Tue, 19 Jan 2010 21:44:51 +0200
From: yavetskiy@kpi.ua
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: www-data <www-data@mail0.kpi.ua>
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad)	frames
	not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello.

I have the same problem with bridging 802.3ad frames.

But rules:
ebtables -A INPUT -p 0x8809 -j ACCEPT
ebtables -A FORWARD -p 0x8809 -j ACCEPT
are not enough to solve this problem, it still doesn't work for me.
I have vanila kernel 2.6.32 with no patches, Debian squeeze, eth1 and  
eth2 interfaces in bridge with stp disabled.
Maybe I've missed something? Do you have any ideas?
Thank you.


--
WBR
Yavetkiy Yuriy

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

