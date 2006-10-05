Message-ID: <4524BFD5.4080203@cambridgebroadband.com>
Date: Thu, 05 Oct 2006 09:18:29 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
In-Reply-To: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@gmail.com>
Cc: bridge@lists.osdl.org

> 
> Now for the PROBLEM! The bridge can access IP's outside of the subnet 
> via eth0 of the bridge, ie - pinging 128.171.1.1 <http://128.171.1.1>, 
> 128.171.3.13 <http://128.171.3.13>, 64.233.167.99 
> <http://64.233.167.99>. The laptop cannot ping the previously listed 
> IPs. The only thing the laptop can ping is 128.171.103.11 

Hi Chris,

I have seen a problem with some ethernet drivers where the interface
does not go into promiscuous mode automatically as the interface is added
to a bridge.

It's worth trying to do this manually with "ifconfig eth0 promisc" and
likewise for eth1, then seeing if things work.

A few ethernet drivers don't support promiscuous mode at all.  But it
definitely looks to me the way you describe the problem that the devices
on the bridge are not in promiscuous mode.

Regards,

Alex
