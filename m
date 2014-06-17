Return-Path: <nhorman@tuxdriver.com>
From: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20140617113952.GE8539@hmsreliant.think-freely.org>
References: <539EE86E.6030806@profihost.ag>
	<CAHA+R7OrT+x_jvDeqKgFc=ndebhB6qwecJBcT5y0ZAA+hBCJ3Q@mail.gmail.com>
	<6B8712E6-8012-42C3-9D98-0EBD943F2894@profihost.ag>
	<CAHA+R7NUKXJhaX45+OQx3ufxrWjkjnhO84cNznbijOZWru7u6w@mail.gmail.com>
	<CE582178-E749-473F-9D88-E6D7789A3B73@profihost.ag>
	<CAHA+R7Ncr_96hcTCgnxWnjXpKvW09DWMZ7J_W4n3GK0VtEo9VA@mail.gmail.com>
	<835D3F57-EB3A-4D30-B19C-7CC987D06C55@profihost.ag>
	<20140616213019.GA31594@electric-eye.fr.zoreil.com>
	<539FDB02.2020700@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539FDB02.2020700@profihost.ag>
Subject: Re: [Bridge] netconsole breaks netpoll on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 17 Jun 2014 12:18:58 -0000
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Cong Wang <cwang@twopensource.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Francois Romieu <romieu@fr.zoreil.com>, Linux Netdev List <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>

On Tue, Jun 17, 2014 at 08:06:58AM +0200, Stefan Priebe - Profihost AG wrote:
> Am 16.06.2014 23:30, schrieb Francois Romieu:
> > Stefan Priebe - Profihost AG <s.priebe@profihost.ag> :
> > [...]
> >> That sounds great! Is there anything I can do or some code I can port to veth?
> > 
> > You may add an empty handler for .ndo_poll_controller in drivers/net/veth.c
> > and give it a try on current kernel.
> > 
> > It should not be too bad.
> > 
> Why is an empty poll controller enough to fix it? This sounds a bit
> crazy to me.
> 
Because the presence of a non-null poll_controller method is how we determine if
a device supports netpoll.  Most devices require a ndo_poll_controller function
to simulate an interrupt for receiving packets, but virtual devices really
don't, so an empty function sufficies to get the device recognized as having
netpoll support.  See tun_poll_controller as an example
Neil

> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
