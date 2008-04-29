Message-ID: <48173D49.50608@sneakemail.com>
Date: Tue, 29 Apr 2008 17:22:49 +0200
From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?=
	<4ux6as402@sneakemail.com>
MIME-Version: 1.0
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
	<4815ED77.3030306@sneakemail.com>
	<20080428162846.GA17786@tuxdriver.com>
	<4816F896.4040802@sneakemail.com>
	<20080429131543.GA4887@tuxdriver.com>
In-Reply-To: <20080429131543.GA4887@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@lists.linux-foundation.org

Hi all you wonderful people,

Srinivas M.A. srinivas.aji-at-gmail.com |Lists| wrote:
 > The equivalent solution on Linux seems like parprouted
 > (http://www.hazard.maks.net/parprouted/), which also seems to be
 > packaged for Debian, etc. I haven't used it, just found it searching
 > for "arp proxy" and linux. But it seems worth a look.

Yes, I tried parprouted. It works well within what it promises to do.
But broadcast (e.g. for DHCP!) is not supported. It, in turn suggests to
use dhcrelay to support DHCP with parprouted. But I didn't try that. I
still hadn't given up on getting a bridge to work.

But I have now.

John W. Linville linville-at-tuxdriver.com |Lists| wrote:
> For now, my previous recommendation (routing w/ or w/o IP NAT) still
> stands as the simplest and best documented approach.  If that does
> not appeal to you, I suspect that bridging combined with L2 NAT via
> ebtables as described in the URL cited above will work...YMMV.

I've just purchased a 3Com 3CRUSB10075 based on the zd1211 driver. Like
always with Linux it seems, buying hardware is a pseudo-man-month job
understanding the underlying technologies and so forth. Is the zd1211
driver "good"? No idea. Does it support WDS?  Promiscuous mode? No idea.
Will I ever need either? No idea.

The fact that I'm frustrated is not an indication that I'm less than in
awe of the response and attention I've gotten here. Thanks a bundle. I'm
off to enjoying my 3com with parprouted when it arrives and to
experiment with nat, routing and ebtables just in case.

In respect,

Peter
