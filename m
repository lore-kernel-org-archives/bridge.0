Message-ID: <48D94C42.4020605@free.fr>
Date: Tue, 23 Sep 2008 22:06:26 +0200
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <694310.58969.qm@web8804.mail.in.yahoo.com>
In-Reply-To: <694310.58969.qm@web8804.mail.in.yahoo.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bridge is not forwarding the packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org

rahul bhardwaj a écrit :

> Actually my problem is not related to MAC address restrictions from 
> wireless interface/driver. The problem lies mainly in multiple bridges 
> for different vlans. Since bridging happens first, the packet ends up on 
> wrong bridge and gets discarded form that bridge.  If Vlan handling is 
> done prior to bridge handling, my setup will work fine.


Hi Rahul,

Did you try to use ebtables, to arrange for the first bridge to ignore 
the packet tagged as VLAN 100, to give a chance for the second bridge to 
see it ?

I remember seeing this a few month ago in the list, but failed to find 
the exact post. 'hope you will find it by yourself.

	Nicolas.
