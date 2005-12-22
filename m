Date: Thu, 22 Dec 2005 15:18:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] htb accounting on bridge interface
Message-ID: <20051222151841.45fbb8e8@localhost.localdomain>
In-Reply-To: <20051222223423.35638.qmail@web35609.mail.mud.yahoo.com>
References: <20051222223423.35638.qmail@web35609.mail.mud.yahoo.com>
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
To: Ady Deac <adydeac@yahoo.com>
Cc: bridge@lists.osdl.org

On Thu, 22 Dec 2005 14:34:23 -0800 (PST)
Ady Deac <adydeac@yahoo.com> wrote:

> Hi!
> 
> I am using a linux bridge as an internet gateway. I have eth0 as the external interface, eth1 and
> tap0 (OpenVPN) bridged together (br0). I was trying to make a seamless accounting for br0 with tc
> and htb (hand made scripts). The accounting is not working for br0, instead I have to make
> accounting on eth1 and tap0.
> Is this the right way? I only want to limit the trafic between eth1 and eth0 + viceversa and tap0
> and eth + viceversa.
> 
> Thanks in advance,
> Ady Deac
> 

The bridge interface itself normally doesn't have an output queue for
queuing stuff to hang off because it is not limited by a single hardware
device. You can place a queue there with traffic control tools, but
it would only make sense if doing rate control.

Also br0 is only invoked for locally generated packets. If you are a gateway,
all traffic passing through never touches the br0 pseudo-interface.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
