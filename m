Date: Wed, 17 Aug 2005 09:21:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [BRIDGE]A basic question: what's the relationship of the Rx/Tx
	packets count between the bridge and its enslaved NIC.
Message-ID: <20050817092132.3160f383@dxpl.pdx.osdl.net>
In-Reply-To: <fd54385205081520403350f16a@mail.gmail.com>
References: <fd54385205081520403350f16a@mail.gmail.com>
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
To: Steven Zhang <zhangseven@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 16 Aug 2005 11:40:40 +0800
Steven Zhang <zhangseven@gmail.com> wrote:

> I have a bridge br0, it enslaves two NICs: eth0 and eth1. 
> By using "cat /proc/net/dev ", i can see the Rx/Tx packets and bytes
> through each interface. just like this:



> I wonder the meaning of the value of the br0,  it's Rx/Tx packets is
> less than both eth0 and eth1.
> what's the relationship of the values between bridge and it's enslaved NIC?
> 

The pseudo-device br0 is used for locally generated traffic

There will be several possible flows through a bridge:

Traffic going from 
	eth0 to eth1 will increase eth0:Rx and eth1:Tx
	eth1 to eth0               eth1:Rx     eth0:Tx
Locally transmits to eth0          br0:Tx  and eth0:Tx
Locally received via eth0          br0:Rx  and eth0:Rx

Also, packets generated locally with unknown destination
will be flooded to both eth0 and eth1.

You get the idea
