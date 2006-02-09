Date: Thu, 9 Feb 2006 09:18:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Information needed about bridge c code
Message-ID: <20060209091802.2cb9aa1d@dxpl.pdx.osdl.net>
In-Reply-To: <34d8b2fe0602010131n884f73bt@mail.gmail.com>
References: <34d8b2fe0602010131n884f73bt@mail.gmail.com>
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
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

On Wed, 1 Feb 2006 10:31:07 +0100
Louis Croisez <louis.croisez@gmail.com> wrote:

> Hello,
> i need to write a little personal patch in the bridge code.
> For this patch, i need to know the original src and dst mac addresses
> of the packet incoming to the bridge. As i work on a brouter (some
> packets are bridged, some are routed based on ebtable rules), packets
> that are routed have their mac addresses modified by the IP stack).

At start of br_handle_frame, dst mac address in skb is as received on
wire. Call sequence is:

netif_receive_skb
	handle_bridge
		br_handle_frame
			
The skb on the pre-routing chain is actually after brouting but before
going through bridge forwarding.

> I put a software probe in br_input.c::br_handle_frame( ), but there,
> the dst mac address is already replaced by the bridge local mac
> address.
> My question is: where must i put the probe to get the original src and
> dst mac addresses? At the driver level? In the bridge, but where?
> 
> Thx in advance.
> PS: please CC  to louis.croisezATgmail.com, because i am receiving the
> digest once per day.
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
