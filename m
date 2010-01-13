MIME-Version: 1.0
In-Reply-To: <8cad0aa1001130921v7d3b1f90ua3c0491737181a09@mail.gmail.com>
References: <8cad0aa1001130853i38d35b5ft7cd23b749ae891ce@mail.gmail.com>
	<20100113085500.554ba62c@nehalam>
	<8cad0aa1001130921v7d3b1f90ua3c0491737181a09@mail.gmail.com>
Date: Wed, 13 Jan 2010 18:42:22 +0100
Message-ID: <8cad0aa1001130942r325da153pfdfc7193f3ad1c72@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad) frames
	not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

It is working.

I have to do this :
ebtables -A INPUT -p 0x8809 -j ACCEPT
ebtables -A FORWARD -p 0x8809 -j ACCEPT

When I send a packet on my first interface, it is going on my second
interface if and only if I have both INPUT and FORWARD.

Thanks for your help !!

JM
