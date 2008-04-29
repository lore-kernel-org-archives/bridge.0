Message-ID: <fed120860804290510o5c59c9bap2cdd68865ff839f7@mail.gmail.com>
Date: Tue, 29 Apr 2008 17:40:37 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <4816F896.4040802@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
	<4815ED77.3030306@sneakemail.com>
	<20080428162846.GA17786@tuxdriver.com>
	<4816F896.4040802@sneakemail.com>
Subject: Re: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" <4ux6as402@sneakemail.com>
Cc: bridge@lists.linux-foundation.org

>
>  Ok, my wireless expert friend (a windows guy) was surprised that
>  bridging between ethernet and wireless wasn't straightforward in linux.
>  He says it is trivial and works in Windows, supported by this:
>  http://www.microsoft.com/windowsxp/using/networking/expert/crawford_02april22.mspx
>  I'll try it next time I get the chance.


The ForceCompatibilityMode option is supposed to work with adapters
that don't support promiscuous mode, so I can only guess that it must
be doing L2 NAT, (with proxy ARP).

The equivalent solution on Linux seems like parprouted
(http://www.hazard.maks.net/parprouted/), which also seems to be
packaged for Debian, etc. I haven't used it, just found it searching
for "arp proxy" and linux. But it seems worth a look.
