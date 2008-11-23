From: Thomas Mueller <thomas@chaschperli.ch>
Date: Sun, 23 Nov 2008 12:26:08 +0000 (UTC)
Message-ID: <ggbi50$cf1$1@ger.gmane.org>
References: <gg92a9$5ot$1@ger.gmane.org> <20081122224021.39238f0c@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] bridge changes id on addif - is that normal?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org


>> 
> First off the hardware address of the bridge is by default the lowest of
> all the interfaces (unless you set it). This was done by original author
> to deal with case of interfaces added out of order on boot.

ok, this would be nice if that would be mentioned on the https://
www.linuxfoundation.org/en/Net:Bridge#FAQ page. I couldn't find any 
information on how the bridge-id is evaluated on searching the internet.

i've now set it to a lower mac-addr  and now the bridge-id doesn't change 
on addif. 


> 
> The second issue is because you are making a loop in your network. If
> you had STP enabled it would probably scream at you.

ok, that is what I assuemd could be the problem. 

Thank you!

- Thomas

