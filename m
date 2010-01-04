MIME-Version: 1.0
Date: Mon, 4 Jan 2010 15:27:21 +0100
Message-ID: <8cad0aa1001040627l48c22f11id1c48c6cfaac3585@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Ulog : recvfrom no space available => how do I calculate a
	good value ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi there !

I keep trying to use the ulog/netlink system to receive only the
packets I'm interested by and bridging everything else...
I have a problem using this, because of a too small buffer ?

I am using the recvfrom as the example given on the website, and I am
getting a "no space buffer available" when I have packets  about
2Mbits/sec...
This is very short, as I would like to have >= 100Mbits/sec.

I saw in the manpage an option : --ulog-cprange but I don't understand
how it works...

How can I calculate the range and/or threshold in order to have the
highest rate possible ?

Thanks in advance.
Best Regards,
JM
