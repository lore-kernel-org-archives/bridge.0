Return-Path: <bdschuym@pandora.be>
Message-ID: <52A0EBEA.4020808@pandora.be>
Date: Thu, 05 Dec 2013 22:11:06 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <20131130085440.GA11638@glanzmann.de>
In-Reply-To: <20131130085440.GA11638@glanzmann.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Packet reflection breaks Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Glanzmann <thomas@glanzmann.de>, bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, gernoth@cs.fau.de

Thomas Glanzmann schreef op 30/11/2013 9:54:
> I found one other reference which confirms this problem.
>
> http://serverfault.com/questions/518254/linux-container-bridge-filters-arp-reply

The author answered his own question stating it was an issue in his 
network :-)

> Also I wonder what else than source natting broadcast request we could
> do to fight the symptoms? For example I would like to drop all packets
> with the source mac address from 00:50:56:98:12:ed which are comming in
> via eth1. I tried this using ebtables, arptables and iptables but did
> not get the syntax right. Has someone, something I could try?
>

ebtables -t nat -A PREROUTING -s 00:50:56:98:12:ed -i eth1 -j DROP

Use PREROUTING so that the Linux bridge fdb isn't updated. A better 
solution is probably to fix your network.


cheers,
Bart

