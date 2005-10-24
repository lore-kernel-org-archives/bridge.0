Date: Tue, 25 Oct 2005 01:56:07 +0200
From: Michel Pastor <K@codefx.org>
Subject: Re: [Bridge] single briged network internet access problems
Message-Id: <20051025015607.2cd2c189.K@codefx.org>
In-Reply-To: <20051024163055.5b3d4f2f@dxpl.pdx.osdl.net>
References: <20051025010230.2d6f330f.K@codefx.org>
	<20051024163055.5b3d4f2f@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


Forget the part about tcpdump, I rebooted the machine and the default route was reset to host2.
It seems I was right. As you can see packets is output through eth2 with an internal ip even with the MASQUERADE rule...

# tcpdump -i eth2 icmp
listening on eth2, link-type EN10MB (Ethernet), capture size 96 bytes
01:25:50.114069 IP 10.22.2.4 > mutu.nuxit.net: ICMP echo request, id 247, seq 0, length 64
01:25:51.113813 IP 10.22.2.4 > mutu.nuxit.net: ICMP echo request, id 247, seq 1, length 64

but with host2 as default route it'ok :

# tcpdump -i eth2 icmp
listening on eth2, link-type EN10MB (Ethernet), capture size 96 bytes
01:54:12.666919 IP 8X.242.21.225 > janus-2-20.x-echo.com: ICMP echo request, id 250, seq 0, length 64
01:54:12.719119 IP janus-2-20.x-echo.com > 8X.242.21.225: ICMP echo reply, id 250, seq 0, length 64
01:54:13.666751 IP 8X.242.21.225 > janus-2-20.x-echo.com: ICMP echo request, id 250, seq 1, length 64
01:54:13.706618 IP janus-2-20.x-echo.com > 8X.242.21.225: ICMP echo reply, id 250, seq 1, length 64

This confirm that the packets didn't get through the NAT-POSTROUTING chain.
So, why ?

Thanks
- Michel
