Message-ID: <009b01c3e429$6db90560$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <Pine.LNX.4.33.0401191551410.3962-100000@ns.varna.net>
Subject: Re: [Bridge] received packet with  own address as source address
Date: Mon, 26 Jan 2004 10:28:24 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

> just my $0.02:
>
> ethertap interfaces has fake mac addresses, generated somehow by the
> tun/tap driver, and they are same on both sides in your case. Don't know
> why.
>
> -- Nikolay Datchev

Not sure what gave me the idea to use the same MAC on the TAP and inside the UML.
Since the earlier versions of bridge didn't complain about it, perhaps I figured I
should fight it :)  Anyways, using a different MAC for the TAP and the UML seems
to have solved all of the issues.

Thanks for the help!
-Chris

