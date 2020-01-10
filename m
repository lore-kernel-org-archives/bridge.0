Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u3jxCHUDd5Pm/Y2q0b/qKxrWWseDBaS/hK6okC7Pk38=; b=YHFcu8ccMp5yFy9YS4lh6wzLz/
 8fCAAtavMf+JJh9EqEP0ZkXV6mLtbmco+6Jx7JSgW3DgH0KSS+gmK9gMPsupNwqNRy56wsbsSNszi
 uYcm8f/wSwIdznLSiE+eT8ROc96UUbliZxKnHfakYQO2WZo+4U4euwJOt0NPElAigykE=;
Date: Fri, 10 Jan 2020 21:33:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200110203341.GU19739@lunn.ch>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
 <20200110160456.enzomhfsce7bptu3@soft-dev3.microsemi.net>
 <CA+h21hrq7U4EdqSgpYQRjK8rkcJdvD5jXCSOH_peA-R4xCocTg@mail.gmail.com>
 <20200110172536.42rdfwdc6eiwsw7m@soft-dev3.microsemi.net>
 <20200110175608.GK19739@lunn.ch>
 <20200110201248.tletol7glyr4soqz@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110201248.tletol7glyr4soqz@soft-dev3.microsemi.net>
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, anirudh.venkataramanan@intel.com, Jiri Pirko <jiri@mellanox.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, David Ahern <dsahern@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Jan 10, 2020 at 09:12:48PM +0100, Horatiu Vultur wrote:
> The 01/10/2020 18:56, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > > Horatiu, could you also give some references to the frames that need
> > > > to be sent. I've no idea what information they need to contain, if the
> > > > contents is dynamic, or static, etc.
> > > It is dynamic - but trivial...
> > 
> > If it is trivial, i don't see why you are so worried about abstracting
> > it?
> Maybe we misunderstood each other. When you asked if it is dynamic or
> static, I thought you meant if it is the same frame being send repeated
> or if it needs to be changed. It needs to be changed but the changes are
> trivial, but it means that a non-MRP aware frame generator can't
> properly offload this.

The only frame generator i've ever seen are for generating test
packets. They generally have random content, random length, maybe the
option to send invalid CRC etc. These are never going to work for MRP.
So we should limit our thinking to hardware specifically designed for
MRP offload.

What we need to think about is an abstract model for MRP offload. What
must such a bit of hardware do? What parameters do we need to pass to
it? When should it interrupt us because some event has happened?

Once we have an abstract model, we can define netlink messages, or
devlink messages. And you can implement driver code which takes this
abstract model and implements it for your real hardware. And if you
have the abstract model correct, other vendors should also be able to
implement drivers as well.

Since this is a closed standard, there is not much the rest of us can
do. You need to define this abstract model. We can then review it.

    Andrew
