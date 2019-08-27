Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=J28up6uPKD34qaYuEApixR8UwpIcwgN+tKjvn/kdwk8=;
	b=pMVrBsv09u5KWA+6vj2Cr0qR0GSZe6r8BMU1JSA+mY2m8bDJ+IdYJXV+hJDfmP273h
	03KsR0CTQqVWzTM8EllBHW37q99IulCpwRlLntm1wh7QpBeheqcUWjdGcF92vEjKdwGe
	JWg1stYWqsmHKwaAOkhxXnI4at6LB104kKnM4BFKCBSqOUYTlJLleTaPM+cWFcES1i88
	zXTO9JvkAZyanLSswiDgGLU/w5Lg9OUsu2V4nZRlg9a47CKLJgik6d2SfwFNb8UzzLdP
	TduGiWMz2vDnqLl/Tjwin5PPv0YyzSGJtEK4Qh0lsI17GPFMi0jTeoxn4o37yhTPsYs/
	Yajw==
MIME-Version: 1.0
References: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
	<20190826123811.GA13411@lunn.ch>
	<20190827101033.g2cb6j2j4kuyzh2a@soft-dev3.microsemi.net>
	<20190827131824.GC11471@lunn.ch>
In-Reply-To: <20190827131824.GC11471@lunn.ch>
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 27 Aug 2019 17:55:00 +0300
Message-ID: <CA+h21hrRafYQm8eOcXjNVwudDbu-2=miWD6nCUJdh0jAGE319w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH v2 0/3] Add NETIF_F_HW_BR_CAP feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, nikolay@cumulusnetworks.com, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, UNGLinuxDriver@microchip.com, "Allan W. Nielsen" <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

On Tue, 27 Aug 2019 at 16:20, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > That sounds like a great idea. I was expecting to add this logic in the
> > set_rx_mode function of the driver. But unfortunetly, I got the calls to
> > this function before the dev->promiscuity is updated or not to get the
> > call at all. For example in case the port is member of a bridge and I try
> > to enable the promisc mode.
>
> Hi Horatiu
>
> What about the notifier? Is it called in all the conditions you need
> to know about?
>
> Or, you could consider adding a new switchdev call to pass this
> information to any switchdev driver which is interested in the
> information.
>
> At the moment, the DSA driver core does not pass onto the driver it
> should put a port into promisc mode. So pcap etc, will only see
> traffic directed to the CPU, not all the traffic ingressing the
> interface. If you put the needed core infrastructure into place, we
> could plumb it down from the DSA core to DSA drivers.
>
> Having said that, i don't actually know if the Marvell switches
> support this. Forward using the ATU and send a copy to the CPU?  What
> switches tend to support is port mirroring, sending all the traffic
> out another port. A couple of DSA drivers support that, via TC.
>

But the CPU port is not a valid destination for port mirroring in DSA,
I might add.

>         Andrew

Regards,
-Vladimir
