Message-ID: <8cbd14710609010117n60b7e35bge7147abe8f3c259e@mail.gmail.com>
Date: Fri, 1 Sep 2006 04:17:41 -0400
From: Skept <impossibleprobability@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: Re: [Bridge] Trouble with ARP traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Raffaele

If you don't want to see much arp traffic on eth1, assuming that you
have a subnet 10.190.190.0/24, with 10.190.190.1 on eth1 and the rest
of the hosts on eth0, you can use for example, the following filter

ebtables -N f1
ebtables -P f1 DROP
ebtables -t filter -A FORWARD -i eth0 -o eth1 -p ARP -j f1
ebtables -t filter -A f1 -p ARP --arp-ip-src 10.190.190.0/24
--arp-ip-dst 10.190.190.1 -j ACCEPT

That way you wont see much arp broadcast traffic on eth1. Hope it helps.

Skept
