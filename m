DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
	bh=Xdbj4LU7bGZDK0P4qmpD52XGL5PnuE3+7wOyn5yMcHA=;
	b=XFk/W1uEgT3RBwTO++39zvUykvwtXrvakvJkz7oSweL0Fqy90DvQbM9Jn0jF7c6dBamn/5vIOtY2CYf7/ErQO2cwu661Ekgg8+yjacTdgwiSZz/LDcTjeTpv1Br3U2fWJoSBl0rxFTxZq3nfBO/wFqK5cHREYhOw7uLimdNtGIU=
Message-ID: <4781728A.8070108@gmail.com>
Date: Mon, 07 Jan 2008 02:30:02 +0200
From: Casper Gripenberg <casper.cg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge with IP address -> unable to connect to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hi,

I tried sending this earlier, but it didn't come through.
Apologies if this appers twice on the list.

I'm running bridging using the brouter setup described on
this page:

http://ebtables.sourceforge.net/examples.html
"Making a brouter".

The setup described there is like this:

ifconfig br0 0.0.0.0
ifconfig eth0 172.16.1.1 netmask 255.255.255.0
ifconfig eth1 172.16.2.1 netmask 255.255.255.0
ebtables -t broute -A BROUTING -p ipv4 -i eth0 --ip-dst 172.16.1.1 -j DROP
ebtables -t broute -A BROUTING -p ipv4 -i eth1 --ip-dst 172.16.2.1 -j DROP
ebtables -t broute -A BROUTING -p arp -i eth0 -d $MAC_OF_ETH0 -j DROP
ebtables -t broute -A BROUTING -p arp -i eth1 -d $MAC_OF_ETH1 -j DROP

My setup is different in that I use a public DHCP IP address
for eth0, and an interal private IP for eth1.

Internet <-> DHCP <-> eth0 br0 eth1 <-> my internal net

The bridge bridges traffic fine, but the problems come when
I try to access eth0 from my internal network.

I can get to eth0 fine if I access it from the internet,
but if I try to access it from my internal network then
it won't work.

The computer on the internal net has a public internet
IP (aquired from the same DHCP box that gave eth0 its
address). So that should not be the problem.

If I look at the arp table on my computer on the
internal net it has the ARP address of eth1 for the
IP of eth0. This seems correct, right?..since we want
to get to eth1 in order to jump to eth0.

Is there some way to get this to work? In the end I want
to be able to filter different ports on eth0 based on if
the traffic comes from the internet or from the internal
net. I think there is just some magic ebtables potion
that will solve it(?)..but I don't know how to make it :-/

Thanks.

Casper


